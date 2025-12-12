import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  const SubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1.0,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withOpacity(.92),
          fontSize: 18,
          height: 1.2,
          shadows: [
            Shadow(blurRadius: 20, color: Colors.blueAccent.withOpacity(.06)),
          ],
        ),
      ),
    );
  }
}
