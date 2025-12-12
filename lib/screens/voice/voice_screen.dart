import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/voice_provider.dart';
import '../../widgets/hologram.dart';
import '../../widgets/waveform.dart';
import '../../widgets/agent_feed.dart';
import '../../widgets/control_bar.dart';
import '../../widgets/subtitle_text.dart';
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

class _VoiceView extends StatefulWidget {
  const _VoiceView();

  @override
  State<_VoiceView> createState() => _VoiceViewState();
}

class _VoiceViewState extends State<_VoiceView> with TickerProviderStateMixin {
  late AnimationController _introController;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vp = context.watch<VoiceProvider>(); // FIX: This is the correct variable

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background hologram layer
            const Positioned.fill(child: HologramBackground()),

            // UI content
            Positioned.fill(
              child: Column(
                children: [
                  const SizedBox(height: 18),

                  // TOP ROW: waveform + agent feed
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        // waveform centered
                        Expanded(
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: vp.isListening ? 1.0 : 0.7,
                              duration: const Duration(milliseconds: 400),
                              child: SizedBox(
                                width: 220,
                                height: 48,
                                child: Waveform(
                                  active: vp.isListening,
                                  barCount: 5,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Camera feed (FIXED)
                        CameraFeed(
                          video: vp.cameraElement,
                          size: 92,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Subtitle text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SubtitleText(
                      text: vp.lastResponse.isEmpty
                          ? (vp.isListening
                              ? "FRIDAY is listening, ask her a question"
                              : "Tap the Mic To Talk Alan")
                          : vp.lastResponse,
                    ),
                  ),

                  const Spacer(),

                  // Bottom control bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: ControlBar(
                      isListening: vp.isListening,
                      onMicTap: () async => await vp.toggleMic(),
                      onSendTest: () => vp.requestTextResponse("Hello Alan"),
                    ),
                  ),
                ],
              ),
            ),

            // Hologram ring overlay (center)
            const Center(
              child: SizedBox(
                width: 460,
                height: 460,
                child: HologramRing(),
              ),
            ),

            // Connection status badge
            Positioned(
              left: 18,
              top: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(.06)),
                ),
                child: Row(
                  children: [
                    Icon(
                      vp.isConnected ? Icons.wifi : Icons.wifi_off,
                      color: vp.isConnected ? Colors.greenAccent : Colors.redAccent,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      vp.isConnected ? "Online" : "Offline",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.85), fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
