import 'package:flutter/material.dart';

class MicButton extends StatelessWidget {
  final bool isActive;      // true when listening
  final VoidCallback onTap;

  const MicButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double size = 76;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? Colors.redAccent.withOpacity(.9)
              : Colors.white.withOpacity(.12),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(.5),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ]
              : [],
          border: Border.all(
            color: Colors.white.withOpacity(.2),
            width: 1.4,
          ),
        ),
        child: Icon(
          isActive ? Icons.mic : Icons.mic_none,
          color: Colors.white,
          size: 34,
        ),
      ),
    );
  }
}
