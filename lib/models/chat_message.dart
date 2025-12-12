class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  // ------------------------------------------------------------
  // Convert to JSON (optional, if saving history)
  // ------------------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "isUser": isUser,
      "timestamp": timestamp.toIso8601String(),
    };
  }

  // ------------------------------------------------------------
  // Convert from JSON
  // ------------------------------------------------------------
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json["text"] ?? "",
      isUser: json["isUser"] ?? false,
      timestamp: DateTime.tryParse(json["timestamp"] ?? "") ?? DateTime.now(),
    );
  }
}
