import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../services/livekit_service.dart';

class VoiceProvider extends ChangeNotifier {
  final LiveKitService _lk = LiveKitService();

  bool isConnected = false;
  bool isListening = false;
  bool agentSpeaking = false;

  String lastResponse = "Tap the mic to talk";

  html.VideoElement? cameraElement;
  bool cameraReady = false;

  // 🔐 TEMP (replace later with backend token)
  final String livekitUrl = "wss://YOUR_PROJECT.livekit.cloud";
  final String livekitToken = "PASTE_JWT_TOKEN";

  VoiceProvider() {
    _lk.onConnectionChange = (c) {
      isConnected = c;
      if (!c) isListening = false;
      notifyListeners();
    };

    _lk.onAgentSpeaking = () {
      agentSpeaking = true;
      lastResponse = "ALAN speaking…";
      notifyListeners();
    };

    _lk.onAgentStopped = () {
      agentSpeaking = false;
      lastResponse = "Listening…";
      notifyListeners();
    };

    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      cameraElement = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.objectFit = "cover";

      final stream =
          await html.window.navigator.mediaDevices!.getUserMedia({
        "video": true,
        "audio": false,
      });

      cameraElement!.srcObject = stream;
      cameraReady = true;
    } catch (_) {
      cameraReady = false;
    }
    notifyListeners();
  }

  Future<void> connect() async {
    if (isConnected) return;
    await _lk.connect(url: livekitUrl, token: livekitToken);
  }

  Future<void> toggleMic() async {
    if (!isConnected) await connect();
    await _lk.toggleMic();
    isListening = _lk.micEnabled;
    notifyListeners();
  }

  @override
  void dispose() {
    _lk.dispose();
    super.dispose();
  }
}
