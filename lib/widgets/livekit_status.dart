import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/voice_provider.dart';

class LiveKitStatus extends StatelessWidget {
  const LiveKitStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final voice = context.watch<VoiceProvider>();

    Color color;
    String label;

    if (voice.isConnected) {
      color = Colors.greenAccent;
      label = "Connected";
    } else if (voice.isConnecting) {
      color = Colors.orangeAccent;
      label = "Connecting…";
    } else {
      color = Colors.redAccent;
      label = "Offline";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
