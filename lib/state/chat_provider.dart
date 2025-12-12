import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/chat_message.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  final ApiService _api = ApiService();
  final scrollController = ScrollController();

  bool isLoading = false;

  // --------------------------------------------------
  // Chat Messages List
  // --------------------------------------------------
  final List<ChatMessage> messages = [];

  // --------------------------------------------------
  // Unique session ID for chat persistence
  // --------------------------------------------------
  final String sessionId = const Uuid().v4();

  ChatProvider() {
    // Optional: load existing history from backend or local storage
  }

  // --------------------------------------------------
  // Send user message → call backend → append response
  // --------------------------------------------------
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    messages.add(ChatMessage(
      text: text,
      isUser: true,
    ));
    notifyListeners();
    _scrollToEnd();

    isLoading = true;
    notifyListeners();

    // --- Backend Request -----------------------------------
    final res = await _api.sendMessage(
      message: text,
      sessionId: sessionId,
    );

    // Extract text (fallback if missing)
    final String reply = res["text"] ?? "No response from server.";

    // Add Alan reply
    messages.add(ChatMessage(
      text: reply,
      isUser: false,
    ));

    isLoading = false;
    notifyListeners();
    _scrollToEnd();
  }

  // --------------------------------------------------
  // Helper: Auto-scroll chat to bottom
  // --------------------------------------------------
  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 80), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
