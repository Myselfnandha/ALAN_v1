import 'package:flutter/material.dart';
import '../utils/helpers.dart';
import '../services/config_service.dart';
import '../utils/alan_logger.dart';

class DiagnosticsProvider extends ChangeNotifier {
  bool isLoading = false;

  bool livekitConnected = false;
  String providerName = "mock";

  int factCount = 0;
  int conversationCount = 0;

  String livekitUrl = "";
  String livekitKeyMasked = "";

  List<String> logs = [];

  Future<void> loadDiagnostics() async {
    isLoading = true;
    notifyListeners();

    try {
      final config = await ConfigService().loadConfig();

      livekitUrl = config["livekit_url"] ?? "";
      final key = config["livekit_key"] ?? "";

      livekitKeyMasked = Helpers.mask(key);

      // memory stats mock
      factCount = 0;
      conversationCount = 0;

      // read logger memory
      logs = AlanLogger().logs;

    } catch (e) {
      logs.add("Diagnostics error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
