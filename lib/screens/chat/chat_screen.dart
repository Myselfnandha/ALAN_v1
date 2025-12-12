import 'package:flutter/material.dart';
import '../../state/chat_provider.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/chat_input.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Chat with Alan",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),

      body: Column(
        children: [
          // -------------------------
          // Chat Messages
          // -------------------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              controller: chat.scrollController,
              itemCount: chat.messages.length,
              itemBuilder: (_, i) {
                final msg = chat.messages[i];
                return ChatBubble(
                  isUser: msg.isUser,
                  text: msg.text,
                );
              },
            ),
          ),

          // -------------------------
          // Input Box
          // -------------------------
          ChatInput(
            onSend: (value) {
              chat.sendMessage(value);
            },
            loading: chat.isLoading,
          ),
        ],
      ),
    );
  }
}
