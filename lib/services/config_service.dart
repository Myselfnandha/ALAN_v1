import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static final ConfigService _instance = ConfigService._internal();
  factory ConfigService() => _instance;
  ConfigService._internal();

  // Keys
  static const String _endpointKey = "api_endpoint";
  static const String _livekitUrlKey = "livekit_url";
  static const String _livekitApiKey = "livekit_api_key";
  static const String _livekitSecretKey = "livekit_api_secret";
  static const String _darkModeKey = "dark_mode";

  // ------------------------------------------------------------
  // Load all settings
  // ------------------------------------------------------------
  Future<Map<String, dynamic>> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "endpoint": prefs.getString(_endpointKey) ?? "",
      "livekit_url": prefs.getString(_livekitUrlKey) ?? "",
      "livekit_key": prefs.getString(_livekitApiKey) ?? "",
      "livekit_secret": prefs.getString(_livekitSecretKey) ?? "",
      "dark_mode": prefs.getBool(_darkModeKey) ?? true,
    };
  }

  // ------------------------------------------------------------
  // Save all settings
  // ------------------------------------------------------------
  Future<void> saveConfig({
    required String endpoint,
    required String livekitUrl,
    required String livekitKey,
    required String livekitSecret,
    required bool darkMode,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_endpointKey, endpoint);
    await prefs.setString(_livekitUrlKey, livekitUrl);
    await prefs.setString(_livekitApiKey, livekitKey);
    await prefs.setString(_livekitSecretKey, livekitSecret);
    await prefs.setBool(_darkModeKey, darkMode);
  }

  // ------------------------------------------------------------
  // For external modules to update only one field
  // ------------------------------------------------------------
  Future<void> setEndpoint(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_endpointKey, value);
  }

  Future<void> setLiveKitUrl(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_livekitUrlKey, value);
  }

  Future<void> setLiveKitKey(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_livekitApiKey, value);
  }

  Future<void> setLiveKitSecret(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_livekitSecretKey, value);
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }
}
