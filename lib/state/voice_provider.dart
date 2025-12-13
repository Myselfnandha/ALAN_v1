import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../services/livekit_service.dart';
import '../services/api_service.dart';

class VoiceProvider extends ChangeNotifier {
  final LiveKitService _lk = LiveKitService();
  final ApiService _api = ApiService();

  bool isConnected = false;
  bool isListening = false;
  bool agentSpeaking = false;

  String lastResponse = "";

  // Camera feed (Web)
  html.VideoElement? cameraElement;
  bool cameraReady = false;

  VoiceProvider() {
    // LiveKit connection state
    _lk.onConnectionChange = (connected) {
      isConnected = connected;
      if (!connected) {
        isListening = false;
        agentSpeaking = false;
      }
      notifyListeners();
    };

    // Agent audio state
    _lk.onAgentSpeaking = () {
      agentSpeaking = true;
      lastResponse = "ALAN is speaking…";
      notifyListeners();
    };

    _lk.onAgentStopped = () {
      agentSpeaking = false;
      lastResponse = "";
      notifyListeners();
    };

    _initCameraFeed();
  }

  // ----------------------------------------------------------
  // CAMERA FEED (Web only)
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
  // LiveKit config
  // ----------------------------------------------------------
  void setConfig({
    required String url,
    required String token,
  }) {
    _lk.setConfig(url: url, token: token);
  }

  Future<void> connect() async {
    if (!isConnected) {
      await _lk.connect();
    }
  }

  // ----------------------------------------------------------
  // REAL mic control (NO mock backend loop)
  // ----------------------------------------------------------
  Future<void> toggleMic() async {
    if (!isConnected) await connect();

    await _lk.toggleMic();
    isListening = _lk.micEnabled;

    notifyListeners();
  }

  // ----------------------------------------------------------
  // Text-only request (kept intentionally)
  // ----------------------------------------------------------
  Future<void> requestTextResponse(String message) async {
    final res = await _api.sendMessage(
      message: message,
      sessionId: "voice-session",
    );

    lastResponse = res["text"] ?? "";
    notifyListeners();
  }
}
