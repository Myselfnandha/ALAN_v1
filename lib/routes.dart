import 'package:flutter/material.dart';

// Screens
import 'screens/intro/intro_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/voice/voice_screen.dart';
import 'screens/memory/memory_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/diagnostics/diagnostics_screen.dart';

class Routes {
  // -------- Route Names --------
  static const String intro = '/intro';
  static const String home = '/';
  static const String chat = '/chat';
  static const String voice = '/voice';
  static const String memory = '/memory';
  static const String settings = '/settings';
  static const String diagnostics = '/diagnostics';

  // -------- Initial Route --------
  static const String initial = intro;

  // -------- Route Map --------
  static final Map<String, WidgetBuilder> map = {
    intro: (_) => const IntroScreen(),      // JARVIS boot animation
    home: (_) => const HomeScreen(),
    chat: (_) => const ChatScreen(),
    voice: (_) => const VoiceScreen(),
    memory: (_) => const MemoryScreen(),
    settings: (_) => const SettingsScreen(),
    diagnostics: (_) => const DiagnosticsScreen(),
  };
}
