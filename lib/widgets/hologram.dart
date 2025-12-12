import 'dart:math';
import 'package:flutter/material.dart';

class HologramBackground extends StatefulWidget {
  const HologramBackground({super.key});

  @override
  State<HologramBackground> createState() => _HologramBackgroundState();
}

class _HologramBackgroundState extends State<HologramBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctl,
      builder: (context, _) {
        return CustomPaint(
          painter: _HologramPainter(_ctl.value),
          child: Container(color: Colors.black),
        );
      },
    );
  }
}

class _HologramPainter extends CustomPainter {
  final double t;
  _HologramPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) * 0.42;

    // subtle radial gradient
    final rect = Rect.fromCircle(center: center, radius: radius * 1.6);
    final grad = RadialGradient(
      colors: [
        Colors.transparent,
        Colors.black.withOpacity(0.25),
        Colors.black.withOpacity(0.6)
      ],
      stops: const [0.0, 0.55, 1.0],
    ).createShader(rect);

    final paint = Paint()..shader = grad;
    canvas.drawRect(Offset.zero & size, paint);

    // moving tiny particles
    final particlePaint = Paint()..color = const Color(0xFF2DD0FF).withOpacity(0.06);
    final rnd = Random(42);
    for (int i = 0; i < 30; i++) {
      final angle = (i * 13.0 + t * 360) % 360;
      final r = radius * (0.4 + (i % 7) * 0.07);
      final dx = center.dx + cos(angle * pi / 180) * r;
      final dy = center.dy + sin(angle * pi / 180) * r * 0.6;
      canvas.drawCircle(Offset(dx, dy), 3.0, particlePaint);
    }

    // faint vertical bars
    final barPaint = Paint()..color = const Color(0xFF2DD0FF).withOpacity(0.03);
    for (int i = -6; i <= 6; i++) {
      final x = center.dx + i * 80.0 + sin(t * 2 * pi + i) * 18;
      canvas.drawRect(Rect.fromLTWH(x, size.height * 0.25, 6, size.height * 0.5), barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _HologramPainter old) => old.t != t;
}

/// Center ring widget used above
class HologramRing extends StatefulWidget {
  const HologramRing({super.key});

  @override
  State<HologramRing> createState() => _HologramRingState();
}

class _HologramRingState extends State<HologramRing> with TickerProviderStateMixin {
  late AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _spin,
        builder: (context, _) {
          final v = _spin.value;
          return CustomPaint(
            painter: _RingPainter(v),
          );
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double t;
  _RingPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = min(size.width, size.height) * 0.45;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..shader = SweepGradient(
        colors: [
          const Color(0xFF2DD0FF).withOpacity(0.05),
          const Color(0xFF2DD0FF).withOpacity(0.55),
          const Color(0xFF2DD0FF).withOpacity(0.18),
        ],
        stops: const [0.0, 0.45, 1.0],
        transform: GradientRotation(2 * pi * t),
      ).createShader(Rect.fromCircle(center: center, radius: r));
    canvas.drawCircle(center, r, ring);

    // inner glow
    final glow = Paint()..color = const Color(0xFF2DD0FF).withOpacity(0.06);
    canvas.drawCircle(center, r * 0.6, glow);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.t != t;
}
