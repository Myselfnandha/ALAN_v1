import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double radius;

  const StatusChip({
    super.key,
    required this.label,
    required this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: color.withOpacity(0.35),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          // Status dot
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),

          // Label
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
