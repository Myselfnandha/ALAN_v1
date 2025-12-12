import 'dart:math';
import 'package:flutter/material.dart';

class Waveform extends StatefulWidget {
  final bool active;
  final int barCount;
  final double height;
  const Waveform({
    super.key,
    this.active = false,
    this.barCount = 6,
    this.height = 40,
  });

  @override
  State<Waveform> createState() => _WaveformState();
}

class _WaveformState extends State<Waveform> with SingleTickerProviderStateMixin {
  late AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barCount = widget.barCount;
    return AnimatedBuilder(
      animation: _ctl,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(barCount, (i) {
            final phase = (_ctl.value * 2 * pi) + i;
            final base = (sin(phase) + 1) / 2;
            final randomFactor = 0.4 + (i % 3) * 0.2;
            final val = widget.active ? (base * randomFactor) : 0.15;
            final h = max(6.0, widget.height * val);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                width: 10,
                height: h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2DD0FF),
                      Colors.white.withOpacity(0.08),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2DD0FF).withOpacity(0.18),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
