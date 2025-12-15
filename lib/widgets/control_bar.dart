import 'package:flutter/material.dart';

class ControlBar extends StatelessWidget {
  final bool isListening;
  final VoidCallback onMicTap;

  const ControlBar({
    super.key,
    required this.isListening,
    required this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMicTap,
      child: Container(
        width: 74,
        height: 74,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isListening ? Colors.redAccent : Colors.cyanAccent,
        ),
        child: const Icon(
          Icons.mic,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }
}
