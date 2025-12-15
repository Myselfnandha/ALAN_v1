import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/voice_provider.dart';
import '../../widgets/waveform.dart';
import '../../widgets/control_bar.dart';
import '../../widgets/camera_feed.dart';

class VoiceScreen extends StatelessWidget {
  const VoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VoiceProvider(),
      child: const _VoiceView(),
    );
  }
}

class _VoiceView extends StatelessWidget {
  const _VoiceView();

  @override
  Widget build(BuildContext context) {
    final vp = context.watch<VoiceProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Waveform(active: vp.isListening || vp.agentSpeaking),
                const SizedBox(width: 16),
                CameraFeed(
                  video: vp.cameraElement,
                  size: 90,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              vp.lastResponse,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const Spacer(),

            ControlBar(
              isListening: vp.isListening,
              onMicTap: () => vp.toggleMic(),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
