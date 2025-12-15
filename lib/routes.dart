import 'package:flutter/material.dart';

import 'screens/intro/intro_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/memory/memory_screen.dart';
import 'screens/diagnostics/diagnostics_screen.dart';

class Routes {
  static const intro = '/intro';
  static const home = '/home';
  static const chat = '/chat';
  static const memory = '/memory';
  static const diagnostics = '/diagnostics';

  static final Map<String, WidgetBuilder> map = {
    intro: (_) => const IntroScreen(),
    home: (_) => const HomeScreen(),
    chat: (_) => const ChatScreen(),
    memory: (_) => const MemoryScreen(),
    diagnostics: (_) => const DiagnosticsScreen(),
  };
}
