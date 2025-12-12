import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final EdgeInsetsGeometry padding;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.padding = const EdgeInsets.only(bottom: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------
          // TITLE
          // ------------------------------------------
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(.9),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),

          // ------------------------------------------
          // SUBTITLE (optional)
          // ------------------------------------------
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                subtitle!,
                style: TextStyle(
                  color: Colors.white.withOpacity(.55),
                  fontSize: 13,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
