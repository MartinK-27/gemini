  import 'package:flutter/material.dart';
  import 'package:flutter_gemini/flutter_gemini.dart';
  import 'package:dash_chat_2/dash_chat_2.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:gemini/presentation/providers.dart';

  class ChatiScreen extends ConsumerStatefulWidget {
    const ChatiScreen({super.key});

    @override
    ChatiScreenState createState() => ChatiScreenState();
  }

  class ChatiScreenState extends ConsumerState<ChatiScreen> {
    Gemini _createGeminiInstance() {
  return Gemini.init(apiKey: "AIzaSyC3LSaAcKZbyyZDFPlvQ0A8K06u5IOPpWQ"); // reemplazá si usás .init() global
  } 


    List<ChatMessage> _currentMessages = [];

    ChatUser currentUser = ChatUser(id: "0", firstName: "User");
    ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Gemini",
      profileImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSm5xNOdkOwTDL9cxAWHDDyjK-6HcM-qHCxhw&s",
    );

    final String personaPrompt =
        "Sos un asistente virtual llamado 'Chati' de la empresa 'HarvestINT', experto en cultivos. Tu tarea es responder dudas sobre agricultura de forma clara y precisa. No te presentes. No rompas el personaje.\n";

    @override
    void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final history = ref.read(chatHistoryProvider);

      if (history.isNotEmpty) {
        setState(() {
          _currentMessages = history;
        });
      } else {
        _showWelcomeMessage();
      }
    });
  }


    void _showWelcomeMessage() {
      Future.delayed(Duration.zero, () {
        ChatMessage welcomeMessage = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "Hola, soy tu asistente personal Chati, ¿en qué puedo ayudarte hoy?",
        );

        setState(() {
          _currentMessages = [welcomeMessage];
        });

        final history = ref.read(chatHistoryProvider.notifier);
        history.state = [welcomeMessage, ...history.state];
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
          messages: _currentMessages,
          inputOptions: InputOptions(
            alwaysShowSend: true,
            sendOnEnter: true,
          ),
        ),
      );
    }

    String _buildFullPrompt(ChatMessage userMessage) {
    return personaPrompt + "Usuario: ${userMessage.text}\nChati:";
  }


    void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      _currentMessages = [chatMessage, ..._currentMessages];
    });

    final history = ref.read(chatHistoryProvider.notifier);
    history.state = [chatMessage, ...history.state];

    String accumulatedResponse = "";

    try {
      final fullPrompt = _buildFullPrompt(chatMessage); // <- PASÁS el mensaje nuevo
      final gemini = _createGeminiInstance();
      gemini.streamGenerateContent(fullPrompt).listen((event) {
        String responsePart = event.content?.parts?.fold("", (prev, part) {
              if (part is TextPart) return "$prev${part.text}";
              return prev;
            }) ?? "";
        accumulatedResponse += responsePart;
      }, onDone: () {
        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: accumulatedResponse,
        );

        setState(() {
          _currentMessages = [message, ..._currentMessages];
        });

        history.state = [message, ...history.state];
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  }