// ignore_for_file: undefined_prefixed_name

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// IMPORTANT: flutter web registry
import 'dart:ui_web' as ui;

class CameraFeed extends StatelessWidget {
  final html.VideoElement? video;
  final double size;

  const CameraFeed({
    super.key,
    required this.video,
    this.size = 92,
  });

  @override
  Widget build(BuildContext context) {
    // Not on web → fallback
    if (!kIsWeb) {
      return _placeholder();
    }

    // camera not ready yet
    if (video == null) {
      return _placeholder();
    }

    // Unique ID for Web widget
    final viewId = "camera-feed-${video.hashCode}";

    // Register HTML video element with Flutter Web
    ui.platformViewRegistry.registerViewFactory(
      viewId,
      (int viewId) => video!,
    );

    return Container(
      width: size,
      height: size * 0.66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(.12)),
        color: Colors.black.withOpacity(.2),
      ),
      child: HtmlElementView(viewType: viewId),
    );
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size * 0.66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(.05),
      ),
      child: const Center(
        child: Icon(Icons.videocam_off, color: Colors.white70),
      ),
    );
  }
}
