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

/*
¡Perfecto! Ahora te entendí claramente lo que querés hacer, y es lo más lógico para un chat real:

✔ Historial de chat guardado en un Provider global, persiste entre pantallas.
✔ Lista de "mensajes del momento" solo dentro de la pantalla actual, lo usa el bot para responder.
❌ El bot no debe usar el historial completo para generar las respuestas, solo lo que está visible en la pantalla.

🚀 Te explico cómo separarlo en dos listas:
chatHistoryProvider → Guarda todo el historial general, persiste entre pantallas.

Lista interna List<ChatMessage> _currentMessages → Solo visible en la pantalla, la usás para:

Mostrar los mensajes actuales.

Enviar el contexto al bot solo con esos mensajes.

🛠 Ejemplo de implementación
1️⃣ En providers.dart:
dart
Copiar
Editar
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

// Historial global de todos los mensajes, persiste entre pantallas
final chatHistoryProvider = StateProvider<List<ChatMessage>>((ref) => []);
2️⃣ En tu ChatiScreen:
dart
Copiar
Editar
class ChatiScreenState extends ConsumerState<ChatiScreen> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> _currentMessages = [];

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

  String _buildFullPrompt() {
    String chatHistory = "";

    for (var msg in _currentMessages.reversed) {
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
    setState(() {
      _currentMessages = [chatMessage, ..._currentMessages];
    });

    final history = ref.read(chatHistoryProvider.notifier);
    history.state = [chatMessage, ...history.state];

    String accumulatedResponse = "";

    try {
      final fullPrompt = _buildFullPrompt();

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
🎯 Resumen:
✅ _currentMessages → Los mensajes visibles en la pantalla, usados para el Prompt.
✅ chatHistoryProvider → Guarda todos los mensajes, no se borra al salir de la pantalla.
✅ Cuando salís del chat y volvés, podés recuperar el historial si querés, o que el bot empiece de cero, como planteaste.

🚀 Bonus: Si querés que al abrir la pantalla se cargue el historial
Podés hacer:

dart
Copiar
Editar
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
Así, si ya hay historial, lo muestra, si no, da el saludo inicial.

¿Querés que te arme el código listo para eso, mostrando historial al volver al chat? Te lo preparo. ¿Avanzamos?








Preguntar a ChatGPT

*/