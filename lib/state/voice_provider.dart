import 'dart:html' as html; // for audio playback on web
import 'package:flutter/material.dart';
import '../services/livekit_service.dart';
import '../services/api_service.dart';

class VoiceProvider extends ChangeNotifier {
  final LiveKitService _lk = LiveKitService();
  final ApiService _api = ApiService();

  bool isConnected = false;
  bool isListening = false;
  String lastResponse = "";
  String? lastAudioUrl;

  // camera feed
  html.VideoElement? cameraElement;
  bool cameraReady = false;

  VoiceProvider() {
    _lk.onConnectionChange = (connected) {
      isConnected = connected;
      if (!connected) isListening = false;
      notifyListeners();
    };

    _initCameraFeed();   // auto-start camera
  }

  // ----------------------------------------------------------
  // CAMERA FEED
  // ----------------------------------------------------------
  Future<void> _initCameraFeed() async {
    try {
      cameraElement = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.objectFit = "cover";

      final stream = await html.window.navigator.mediaDevices!
          .getUserMedia({"video": true, "audio": false});

      cameraElement!.srcObject = stream;
      cameraReady = true;
      notifyListeners();
    } catch (_) {
      cameraReady = false;
      notifyListeners();
    }
  }

  // ----------------------------------------------------------
  // LiveKit mic control
  // ----------------------------------------------------------
  void setConfig({required String url, required String token}) {
    _lk.setConfig(url: url, token: token);
  }

  Future<void> connect() async {
    if (!isConnected) {
      await _lk.connect();
    }
  }

  Future<void> toggleMic() async {
    if (!isConnected) await connect();
    await _lk.toggleMic();
    isListening = _lk.micEnabled;
    notifyListeners();

    if (isListening) {
      // When mic turns on, backend listens for voice → STT → AI reply
      _startVoiceLoop();
    }
  }

  // ----------------------------------------------------------
  // BACKEND VOICE LOOP
  // ----------------------------------------------------------
  Future<void> _startVoiceLoop() async {
    // 1) Ask backend for AI voice response:
    final res = await _api.sendVoiceRequest(
      sessionId: "voice-session",
    );

    lastResponse = res["text"] ?? "";
    lastAudioUrl = res["audio_url"];

    notifyListeners();

    // 2) Play TTS audio
    if (lastAudioUrl != null) {
      final audio = html.AudioElement(lastAudioUrl!)
        ..play()
        ..volume = 1.0;
    }
  }

  // manual text test
  Future<void> requestTextResponse(String message) async {
    final res = await _api.sendMessage(
      message: message,
      sessionId: "voice-session",
    );

    lastResponse = res["text"] ?? "";
    notifyListeners();
  }
}
