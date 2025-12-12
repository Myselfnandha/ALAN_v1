import 'package:flutter/material.dart';
import '../../widgets/alan_avatar.dart';
import '../../widgets/status_chip.dart';

class HomeHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const HomeHeader({
    super.key,
    this.title = "Welcome back, Boss",
    this.subtitle = "How can I assist you today?",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------------
        // Avatar + Status Row
        // -----------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AlanAvatar(size: 52),
            const StatusChip(
              label: "Online",
              color: Colors.greenAccent,
            ),
          ],
        ),

        const SizedBox(height: 22),

        // -----------------------------------
        // Title
        // -----------------------------------
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 6),

        // -----------------------------------
        // Subtitle
        // -----------------------------------
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(.75),
          ),
        ),
      ],
    );
  }
}
