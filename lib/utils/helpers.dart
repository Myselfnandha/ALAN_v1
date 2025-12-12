import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Helpers {
  // ------------------------------------------------------------
  // FORMAT TIMESTAMP → HUMAN READABLE
  // ------------------------------------------------------------
  static String formatTimestamp(String isoString) {
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return "${dt.year}-${_two(dt.month)}-${_two(dt.day)} "
             "${_two(dt.hour)}:${_two(dt.minute)}";
    } catch (_) {
      return isoString;
    }
  }

  static String _two(int n) => n.toString().padLeft(2, "0");

  // ------------------------------------------------------------
  // TRUNCATE LONG TEXT CLEANLY
  // ------------------------------------------------------------
  static String truncate(String text, int max) {
    if (text.length <= max) return text;
    return text.substring(0, max) + "...";
  }

  // ------------------------------------------------------------
  // MASK SENSITIVE STRINGS (API keys, secrets)
  // ------------------------------------------------------------
  static String mask(String input, {int visible = 4}) {
    if (input.length <= visible) return "*" * input.length;
    return input.replaceRange(
      0,
      input.length - visible,
      "*" * (input.length - visible),
    );
  }

  // ------------------------------------------------------------
  // RANDOM SHORT ID (for temporary markers, logs, etc.)
  // ------------------------------------------------------------
  static String randomId([int length = 8]) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final rand = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(rand.nextInt(chars.length))),
    );
  }

  // ------------------------------------------------------------
  // DEBOUNCE FUNCTION (useful for search bars)
  // ------------------------------------------------------------
  static Timer debounce(
    Timer? timer,
    VoidCallback action, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    timer?.cancel();
    return Timer(duration, action);
  }

  // ------------------------------------------------------------
  // SAFE DELAY (wraps Future.delayed)
  // ------------------------------------------------------------
  static Future<void> wait([int ms = 250]) async {
    await Future.delayed(Duration(milliseconds: ms));
  }

  // ------------------------------------------------------------
  // PARSE SAFE INT
  // ------------------------------------------------------------
  static int toInt(dynamic value, [int fallback = 0]) {
    if (value == null) return fallback;
    try {
      return int.parse(value.toString());
    } catch (_) {
      return fallback;
    }
  }

  // ------------------------------------------------------------
  // HEX → COLOR
  // ------------------------------------------------------------
  static Color hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex"; // add opacity
    return Color(int.parse("0x$hex"));
  }
}
