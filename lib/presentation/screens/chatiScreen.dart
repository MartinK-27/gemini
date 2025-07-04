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
  final Gemini gemini = Gemini.instance;

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSm5xNOdkOwTDL9cxAWHDDyjK-6HcM-qHCxhw&s",
  );

  final String personaPrompt =
      "Sos un asistente virtual llamado 'Chati' de la empresa 'HarvestINT', experto en cultivos. Tu tarea es responder dudas sobre agricultura de forma clara y precisa. No rompas el personaje.\n";

  @override
  void initState() {
    super.initState();
    _showWelcomeMessage();
  }

  void _showWelcomeMessage() {
  Future.delayed(Duration.zero, () {
    ChatMessage welcomeMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: "Hola, soy tu asistente personal Chati, ¿en qué puedo ayudarte hoy?",
    );

    final messages = ref.read(chatMessagesProvider.notifier);
    messages.state = [welcomeMessage];
  });
}

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);

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
          alwaysShowSend: true,
          sendOnEnter: true,
        ),
      ),
    );
  }

  String _buildFullPrompt() {
    final messages = ref.read(chatMessagesProvider);
    String chatHistory = "";

    for (var msg in messages.reversed) {
      if (msg.user.id == geminiUser.id) {
        if (msg.text.toLowerCase().contains("soy chati") || msg.text.toLowerCase().contains("asistente personal")) {
          continue;
        }
      }
      String speaker = msg.user.id == currentUser.id ? "Usuario" : "Chati";
      chatHistory += "$speaker: ${msg.text}\n";
    }

    return personaPrompt + chatHistory;
  }

  void _sendMessage(ChatMessage chatMessage) {
    final messagesNotifier = ref.read(chatMessagesProvider.notifier);
    
    messagesNotifier.state = [chatMessage, ...messagesNotifier.state];

    String accumulatedResponse = "";

    try {
      final fullPrompt = _buildFullPrompt();

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

        messagesNotifier.state = [message, ...messagesNotifier.state];
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}
