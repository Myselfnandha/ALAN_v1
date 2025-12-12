import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const LoadingIndicator({
    super.key,
    this.size = 32,
    this.color = Colors.blueAccent,
  });

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulse,
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color.withOpacity(.8),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(.4),
              blurRadius: 15,
              spreadRadius: 1.5,
            )
          ],
        ),
        child: Center(
          child: Container(
            height: widget.size * 0.35,
            width: widget.size * 0.35,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(.85),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
