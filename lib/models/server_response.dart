class ServerResponse {
  final String text;
  final List<dynamic> actions;

  ServerResponse({
    required this.text,
    required this.actions,
  });

  // ------------------------------------------------------------
  // Factory: JSON → ServerResponse
  // ------------------------------------------------------------
  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      text: json["text"]?.toString() ?? "",
      actions: json["actions"] is List ? json["actions"] : [],
    );
  }

  // ------------------------------------------------------------
  // Serialize to JSON (rarely used but useful for logging)
  // ------------------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "actions": actions,
    };
  }
}
