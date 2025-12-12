import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double borderOpacity;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 16,
    this.opacity = 0.08,
    this.borderOpacity = 0.12,
    this.padding = const EdgeInsets.all(14),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.white.withOpacity(borderOpacity),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
