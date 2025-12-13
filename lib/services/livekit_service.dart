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
  void Function()? onAgentSpeaking;
  void Function()? onAgentStopped;

  bool _micEnabled = false;
  bool get micEnabled => _micEnabled;

  void setConfig({required String url, required String token}) {
    livekitUrl = url;
    livekitToken = token;
  }

  Future<void> connect() async {
    if (room != null) return;

    room = Room();
    await room!.connect(livekitUrl, livekitToken);

    localParticipant = room!.localParticipant;

    room!.on<TrackSubscribedEvent>((e) {
      if (e.track.kind == TrackType.AUDIO) {
        e.track.start();
        onAgentSpeaking?.call();
      }
    });

    room!.on<TrackUnsubscribedEvent>((_) {
      onAgentStopped?.call();
    });

    room!.on<RoomDisconnectedEvent>((_) {
      onConnectionChange?.call(false);
    });

    onConnectionChange?.call(true);
  }

  Future<void> toggleMic() async {
    if (localParticipant == null) return;
    _micEnabled = !_micEnabled;
    await localParticipant!.setMicrophoneEnabled(_micEnabled);
  }
}
