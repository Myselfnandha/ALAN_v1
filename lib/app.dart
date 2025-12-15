import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/alan_theme.dart';
import 'screens/intro/intro_screen.dart';


class AlanApp extends StatelessWidget {
  const AlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ALAN",
      theme: AlanTheme.dark,
      home: IntroScreen(),
      routes: Routes.map,
    );
  }
}
