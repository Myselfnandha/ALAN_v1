import 'package:flutter/material.dart';

class AgentFeed extends StatelessWidget {
  final double size;
  final String? avatarAsset;
  const AgentFeed({super.key, this.size = 80, this.avatarAsset});

  @override
  Widget build(BuildContext context) {
    final borderGlow = BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.blueAccent.withOpacity(.16), blurRadius: 18, spreadRadius: 2),
      ],
    );

    return Container(
      width: size,
      height: size * 0.66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(.04),
        border: Border.all(color: Colors.white.withOpacity(.06)),
      ),
      child: Stack(
        children: [
          // video / avatar content
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: avatarAsset == null
                ? Container(
                    color: Colors.white.withOpacity(.06),
                    child: Center(
                      child: Icon(Icons.person, color: Colors.white.withOpacity(.9), size: size * 0.34),
                    ),
                  )
                : Image.asset(
                    avatarAsset!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.white.withOpacity(.06),
                      child: Center(
                        child: Icon(Icons.person, color: Colors.white.withOpacity(.9), size: size * 0.34),
                      ),
                    ),
                  ),
          ),

          // top-right mic indicator
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.45),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(.06)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.mic, size: 12, color: Colors.white70),
                  SizedBox(width: 4),
                  Text("REC", style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ),

          // border glow overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: borderGlow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
