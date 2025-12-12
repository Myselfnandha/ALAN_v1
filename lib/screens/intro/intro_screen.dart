import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../routes.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _fadeController;

  String bootText = "";
  final String fullText = "BOOTING FRIDAY SYSTEM...";

  @override
  void initState() {
    super.initState();

    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _startTypingAnimation();

    Future.delayed(const Duration(seconds: 4), () {
      _fadeController.forward();
    });

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }

  @override
  void dispose() {
    _ringController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _startTypingAnimation() async {
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 55));
      setState(() {
        bootText = fullText.substring(0, i + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // glowing reactor ring
          Center(
            child: AnimatedBuilder(
              animation: _ringController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _JarvisRingPainter(_ringController.value),
                  child: const SizedBox(width: 380, height: 380),
                );
              },
            ),
          ),

          // Scanning lines
          Positioned.fill(
            child: CustomPaint(
              painter: _JarvisScanPainter(_ringController.value),
            ),
          ),

          // Boot text typing animation
          Center(
            child: Text(
              bootText,
              style: const TextStyle(
                color: Color(0xFF29E3FF),
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Fade transition overlay
          FadeTransition(
            opacity: _fadeController,
            child: Container(color: Colors.black.withOpacity(.85)),
          ),
        ],
      ),
    );
  }
}

// ------------------------------
//         PAINTERS
// ------------------------------

class _JarvisRingPainter extends CustomPainter {
  final double t;
  _JarvisRingPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.42;

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..shader = SweepGradient(
        colors: [
          const Color(0xFF29E3FF).withOpacity(.1),
          const Color(0xFF29E3FF).withOpacity(.8),
          const Color(0xFF29E3FF).withOpacity(.1),
        ],
        stops: const [0.0, 0.5, 1.0],
        transform: GradientRotation(pi * 2 * t),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, ringPaint);

    // inner glow
    canvas.drawCircle(
      center,
      radius * 0.6,
      Paint()
        ..color = const Color(0xFF29E3FF).withOpacity(0.05)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20),
    );
  }

  @override
  bool shouldRepaint(_JarvisRingPainter old) => true;
}

class _JarvisScanPainter extends CustomPainter {
  final double t;
  _JarvisScanPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final scanPaint = Paint()
      ..color = const Color(0xFF29E3FF).withOpacity(.08);

    final y = size.height * (t % 1);

    canvas.drawRect(
      Rect.fromLTWH(0, y, size.width, 2),
      scanPaint,
    );
  }

  @override
  bool shouldRepaint(_JarvisScanPainter old) => true;
}
