import 'package:flutter/material.dart';

class AppConstants {
  // ------------------------------------------------------------
  // APP INFORMATION
  // ------------------------------------------------------------
  static const String appName = "Alan Assistant";
  static const String version = "1.0.0";

  // ------------------------------------------------------------
  // DEFAULT VALUES (can be overridden by settings)
  // ------------------------------------------------------------
  static const String defaultApiUrl = "";
  static const String defaultLiveKitUrl = "";
  static const String defaultLiveKitKey = "";
  static const String defaultLiveKitSecret = "";

  // ------------------------------------------------------------
  // UI CONSTANTS
  // ------------------------------------------------------------
  static const double padding = 16.0;
  static const double smallPadding = 10.0;
  static const double radius = 12.0;
  static const double largeRadius = 20.0;

  // Animation durations
  static const Duration fastAnim = Duration(milliseconds: 180);
  static const Duration normalAnim = Duration(milliseconds: 300);

  // ------------------------------------------------------------
  // COLORS (minimal use; theme handles the rest)
  // ------------------------------------------------------------
  static const Color accentBlue = Colors.blueAccent;
  static const Color accentRed = Colors.redAccent;
  static const Color accentGreen = Colors.greenAccent;

  // Soft UI overlay color
  static Color translucentWhite(double opacity) =>
      Colors.white.withOpacity(opacity);

  // ------------------------------------------------------------
  // STORAGE KEYS (shared preferences)
  // ------------------------------------------------------------
  static const String storageEndpoint = "api_endpoint";
  static const String storageLiveKitUrl = "livekit_url";
  static const String storageLiveKitKey = "livekit_api_key";
  static const String storageLiveKitSecret = "livekit_api_secret";
  static const String storageDarkMode = "dark_mode";
}
