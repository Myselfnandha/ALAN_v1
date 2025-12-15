import 'package:flutter/material.dart';

class DiagnosticsProvider extends ChangeNotifier {
  bool isLoading = false;

  // ---- EXPECTED BY UI ----
  bool livekitConnected = true;
  String providerName = "livekit";

  int factCount = 0;
  int conversationCount = 0;

  String livekitUrl = "";
  String livekitKeyMasked = "••••";

  List<String> logs = [];

  Future<void> loadDiagnostics() async {
    isLoading = true;
    notifyListeners();

    // MOCK DATA (UI ONLY — FAST)
    await Future.delayed(const Duration(milliseconds: 300));

    livekitConnected = true;
    providerName = "LiveKit";
    factCount = 12;
    conversationCount = 34;

    logs = [
      "System boot OK",
      "LiveKit connected",
      "Mic permission granted",
    ];

    isLoading = false;
    notifyListeners();
  }
}
