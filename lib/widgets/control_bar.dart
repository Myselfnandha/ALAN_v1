import 'package:flutter/material.dart';

class ControlBar extends StatelessWidget {
  final bool isListening;
  final VoidCallback onMicTap;
  final VoidCallback? onSendTest;
  const ControlBar({
    super.key,
    required this.isListening,
    required this.onMicTap,
    this.onSendTest,
  });

  Widget _iconButton(IconData icon, {Color? color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.03),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color ?? Colors.white70, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.45),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(.04)),
      ),
      child: Row(
        children: [
          // mic button
          GestureDetector(
            onTap: onMicTap,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: isListening ? const Color(0xFF0EBEFF) : Colors.white.withOpacity(.06),
                shape: BoxShape.circle,
                boxShadow: isListening
                    ? [BoxShadow(color: Colors.blueAccent.withOpacity(.28), blurRadius: 18, spreadRadius: 2)]
                    : [],
              ),
              child: Icon(isListening ? Icons.mic : Icons.mic_none, color: isListening ? Colors.black : Colors.white, size: 26),
            ),
          ),

          const SizedBox(width: 14),

          // control icons
          _iconButton(Icons.more_horiz, onTap: () {}),
          const SizedBox(width: 8),
          _iconButton(Icons.cameraswitch, onTap: () {}),
          const SizedBox(width: 8),
          _iconButton(Icons.closed_caption, onTap: () {}),
          const SizedBox(width: 8),
          Expanded(child: Container()),

          // Send test text (for quick debug)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(.06),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onSendTest,
            child: const Text("SEND", style: TextStyle(color: Colors.white70)),
          ),

          const SizedBox(width: 12),

          // End call button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text("END CALL", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
