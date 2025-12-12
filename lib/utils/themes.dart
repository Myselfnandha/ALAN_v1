import 'package:flutter/material.dart';

class AlanTheme {
  // ------------------------------------------------------------
  // COLOR PALETTE
  // ------------------------------------------------------------
  static const Color neonBlue = Color(0xFF2D9CFF);
  static const Color surfaceDark = Color(0xFF0D0D0D);
  static const Color surfaceLight = Color(0xFFF3F3F3);

  // ------------------------------------------------------------
  // TEXT STYLES
  // ------------------------------------------------------------
  static const TextStyle _textWhite = TextStyle(
    color: Colors.white,
    fontFamily: "Inter",
  );

  static const TextTheme darkTextTheme = TextTheme(
    bodyLarge: _textWhite,
    bodyMedium: _textWhite,
    bodySmall: _textWhite,
    titleLarge: _textWhite,
    titleMedium: _textWhite,
  );

  // ------------------------------------------------------------
  // DARK THEME (JARVIS MODE)
  // ------------------------------------------------------------
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: surfaceDark,
      fontFamily: "Inter",

      // AppBar
      appBarTheme: const AppBarTheme(
        color: surfaceDark,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: "Inter",
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white12,
        hintStyle: TextStyle(color: Colors.white.withOpacity(.4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(.15)),
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textTheme: darkTextTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.white12,
    );
  }

  // ------------------------------------------------------------
  // LIGHT THEME (Optional)
  // ------------------------------------------------------------
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: surfaceLight,
      fontFamily: "Inter",

      appBarTheme: const AppBarTheme(
        color: surfaceLight,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          fontFamily: "Inter",
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textTheme: Typography.blackMountainView,
      iconTheme: const IconThemeData(color: Colors.black87),
      dividerColor: Colors.black12,
    );
  }
}
