import 'package:flutter/material.dart';
import 'app.dart';
import 'dart:html' as html;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AlanApp());

  // 🔊 JARVIS BOOT VOICE
  _playBootVoice();
}

void _playBootVoice() {
  Future.delayed(const Duration(milliseconds: 1200), () {
    try {
      final synth = html.window.speechSynthesis;
      if (synth == null) return;

      final utterance =
          html.SpeechSynthesisUtterance("System online, Boss.")
            ..rate = 0.9
            ..pitch = 0.85
            ..volume = 1.0;

      final voices = synth.getVoices();

      for (final v in voices) {
        final lang = v.lang;
        final name = v.name;

        if (lang != null &&
            lang.startsWith('en') &&
            name != null &&
            (name.toLowerCase().contains('female') ||
                name.toLowerCase().contains('male'))) {
          utterance.voice = v;
          break;
        }
      }

      synth.speak(utterance);
    } catch (_) {
      // silent fail – never block startup
    }
  });
}
