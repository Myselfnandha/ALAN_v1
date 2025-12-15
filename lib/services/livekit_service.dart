import 'package:livekit_client/livekit_client.dart';

class LiveKitService {
  static final LiveKitService _instance = LiveKitService._internal();
  factory LiveKitService() => _instance;
  LiveKitService._internal();

  Room? room;
  LocalParticipant? localParticipant;
  bool micEnabled = false;

  void Function(bool)? onConnectionChange;
  void Function()? onAgentSpeaking;
  void Function()? onAgentStopped;

  Future<void> connect({
    required String url,
    required String token,
  }) async {
    if (room != null) return;

    room = Room();

    await room!.connect(
      url,
      token,
    );

    localParticipant = room!.localParticipant;

    room!.events.listen((event) {
      if (event is TrackSubscribedEvent &&
          event.track.kind == TrackType.AUDIO) {
        event.track.start();
        onAgentSpeaking?.call();
      }

      if (event is TrackUnsubscribedEvent) {
        onAgentStopped?.call();
      }

      if (event is RoomDisconnectedEvent) {
        onConnectionChange?.call(false);
      }
    });

    onConnectionChange?.call(true);
  }

  Future<void> toggleMic() async {
    if (localParticipant == null) return;
    micEnabled = !micEnabled;
    await localParticipant!.setMicrophoneEnabled(micEnabled);
  }

  void dispose() {
    room?.disconnect();
    room = null;
  }
}
