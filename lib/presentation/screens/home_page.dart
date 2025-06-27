import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSm5xNOdkOwTDL9cxAWHDDyjK-6HcM-qHCxhw&s",
  );

  // Prompt fijo que se le agrega al principio de cada mensaje
  final String personaPrompt =
      "Respondé como un pirata del siglo XVII. Tu nombre es 'Capitan FofoGod'. Usá frases como '¡argh!' y 'mi capitán'. No rompas el personaje nunca.\n";

  @override
  void initState() {
    super.initState();
    _showWelcomeMessage();
  }

  void _showWelcomeMessage() {
    ChatMessage welcomeMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: "¡Ahoy! Soy tu asistente pirata, ¿en qué puedo ayudarte hoy, mi capitán?",
    );

    setState(() {
      messages = [welcomeMessage];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gemini Chat'),
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages,
         inputOptions: InputOptions(
    alwaysShowSend: true, // Muestra el botón de enviar siempre, opcional
    sendOnEnter: true,     // Envía el mensaje al presionar Enter
  ),
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    String accumulatedResponse = "";
    try {
      final fullPrompt = personaPrompt + chatMessage.text;

      gemini.streamGenerateContent(fullPrompt).listen((event) {
        String responsePart = event.content?.parts?.fold("", (prev, part) {
              if (part is TextPart) return "$prev${part.text}";
              return prev;
            }) ??
            "";
        accumulatedResponse += responsePart;
    }, onDone: () {
        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: accumulatedResponse,
        );

        setState(() {
          messages = [message, ...messages];
        });
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}
