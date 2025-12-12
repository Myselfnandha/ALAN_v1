import 'package:flutter/foundation.dart';

class AlanLogger {
  // Singleton
  static final AlanLogger _instance = AlanLogger._internal();
  factory AlanLogger() => _instance;
  AlanLogger._internal();

  // ------------------------------------------------------------
  // In-memory log storage (used by diagnostics screen)
  // ------------------------------------------------------------
  final List<String> _logs = [];

  List<String> get logs => List.unmodifiable(_logs);

  // ------------------------------------------------------------
  // Base log method
  // ------------------------------------------------------------
  void _add(String level, String message) {
    final timestamp = DateTime.now().toIso8601String();
    final entry = "[$timestamp][$level] $message";

    _logs.insert(0, entry); // newest first

    // Optional: print in debug mode only
    if (kDebugMode) {
      print(entry);
    }
  }

  // ------------------------------------------------------------
  // Public logging methods
  // ------------------------------------------------------------
  void debug(String message) => _add("DEBUG", message);
  void info(String message) => _add("INFO", message);
  void warn(String message) => _add("WARN", message);
  void error(String message) => _add("ERROR", message);

  // ------------------------------------------------------------
  // Clear logs (for diagnostics screen)
  // ------------------------------------------------------------
  void clear() {
    _logs.clear();
  }
}
