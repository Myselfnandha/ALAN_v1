import 'package:livekit_client/livekit_client.dart';

class LiveKitService {
  static final LiveKitService _instance = LiveKitService._internal();
  factory LiveKitService() => _instance;
  LiveKitService._internal();

  Room? room;
  LocalParticipant? localParticipant;

  String livekitUrl = "";
  String livekitToken = "";

  void Function(bool connected)? onConnectionChange;

  bool _micEnabled = false;
  bool get micEnabled => _micEnabled;

  void setConfig({
    required String url,
    required String token,
  }) {
    livekitUrl = url;
    livekitToken = token;
  }

  // Connect to LK (mic only)
  Future<void> connect() async {
    if (room != null) return;

    try {
      room = Room();
      await room!.connect(livekitUrl, livekitToken);

      localParticipant = room!.localParticipant;

      room!.addListener(() {
        if (room!.connectionState == ConnectionState.disconnected) {
          onConnectionChange?.call(false);
        }
      });

      onConnectionChange?.call(true);
    } catch (_) {
      onConnectionChange?.call(false);
      rethrow;
    }
  }

  Future<void> disconnect() async {
    try {
      await room?.disconnect();
    } catch (_) {}

    room = null;
    localParticipant = null;
    onConnectionChange?.call(false);
  }

  Future<void> toggleMic() async {
    if (localParticipant == null) return;

    _micEnabled = !_micEnabled;
    await localParticipant!.setMicrophoneEnabled(_micEnabled);
  }
}
