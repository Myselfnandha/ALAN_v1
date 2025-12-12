class MemoryItem {
  final String key;
  final String value;
  final String timestamp; // ISO format from backend

  MemoryItem({
    required this.key,
    required this.value,
    required this.timestamp,
  });

  // ------------------------------------------------------------
  // Convert JSON → MemoryItem
  // ------------------------------------------------------------
  factory MemoryItem.fromJson(Map<String, dynamic> json) {
    return MemoryItem(
      key: json["key"] ?? "",
      value: json["value"] ?? "",
      timestamp: json["updated_at"] ?? json["timestamp"] ?? "",
    );
  }

  // ------------------------------------------------------------
  // Convert MemoryItem → JSON
  // ------------------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
      "timestamp": timestamp,
    };
  }
}
