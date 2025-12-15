import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CameraFeed extends StatelessWidget {
  final html.VideoElement? video;
  final double size;

  const CameraFeed({
    super.key,
    required this.video,
    this.size = 88,
  });

  @override
  Widget build(BuildContext context) {
    if (video == null) {
      return SizedBox(
        width: size,
        height: size,
        child: const DecoratedBox(
          decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
        ),
      );
    }

    final viewId = 'camera-feed-${video.hashCode}';

    ui.platformViewRegistry.registerViewFactory(
      viewId,
      (int _) {
        video!
          ..style.width = '${size}px'
          ..style.height = '${size}px'
          ..style.borderRadius = '50%'
          ..style.objectFit = 'cover';
        return video!;
      },
    );

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: HtmlElementView(viewType: viewId),
      ),
    );
  }
}
