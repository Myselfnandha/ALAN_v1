import 'package:flutter/material.dart';
import '../services/config_service.dart';
import '../services/api_service.dart';
import '../services/livekit_service.dart';

class SettingsProvider extends ChangeNotifier {
  final ConfigService _config = ConfigService();
  final ApiService _api = ApiService();
  final LiveKitService _livekit = LiveKitService();

  // ---------------------------
  // Controllers for TextFields
  // ---------------------------
  final endpointCtrl = TextEditingController();
  final livekitUrlCtrl = TextEditingController();
  final livekitKeyCtrl = TextEditingController();
  final livekitSecretCtrl = TextEditingController();

  bool darkMode = true;
  bool isSaving = false;

  // ---------------------------
  // Load Settings
  // ---------------------------
  Future<void> loadConfig() async {
    final data = await _config.loadConfig();

    endpointCtrl.text = data["endpoint"] ?? "";
    livekitUrlCtrl.text = data["livekit_url"] ?? "";
    livekitKeyCtrl.text = data["livekit_key"] ?? "";
    livekitSecretCtrl.text = data["livekit_secret"] ?? "";

    darkMode = data["dark_mode"] ?? true;

    // Update services instantly
    _api.setBaseUrl(endpointCtrl.text.trim());
    _livekit.setConfig(
      url: livekitUrlCtrl.text.trim(),
      token: livekitKeyCtrl.text.trim(), // token OR main key
    );

    notifyListeners();
  }

  // ---------------------------
  // Save Settings to storage
  // ---------------------------
  Future<void> saveConfig() async {
    isSaving = true;
    notifyListeners();

    await _config.saveConfig(
      endpoint: endpointCtrl.text.trim(),
      livekitUrl: livekitUrlCtrl.text.trim(),
      livekitKey: livekitKeyCtrl.text.trim(),
      livekitSecret: livekitSecretCtrl.text.trim(),
      darkMode: darkMode,
    );

    // Push values into active services
    _api.setBaseUrl(endpointCtrl.text.trim());
    _livekit.setConfig(
      url: livekitUrlCtrl.text.trim(),
      token: livekitKeyCtrl.text.trim(),
    );

    isSaving = false;
    notifyListeners();
  }

  // ---------------------------
  // Toggle Dark Mode
  // ---------------------------
  void setDarkMode(bool v) {
    darkMode = v;
    _config.setDarkMode(v);
    notifyListeners();
  }

  // ---------------------------
  // Dispose controllers
  // ---------------------------
  @override
  void dispose() {
    endpointCtrl.dispose();
    livekitUrlCtrl.dispose();
    livekitKeyCtrl.dispose();
    livekitSecretCtrl.dispose();
    super.dispose();
  }
}
