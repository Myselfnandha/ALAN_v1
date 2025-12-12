import 'package:flutter/material.dart';

class AlanAvatar extends StatelessWidget {
  final double size;
  final bool glow;

  const AlanAvatar({
    super.key,
    this.size = 48,
    this.glow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: glow
            ? [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/alan_avatar.png",
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.blueAccent.withOpacity(.2),
      child: Icon(
        Icons.smart_toy_outlined,
        color: Colors.white.withOpacity(.9),
        size: size * 0.55,
      ),
    );
  }
}
