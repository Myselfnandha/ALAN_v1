import 'package:flutter/material.dart';
import 'routes.dart';
import 'utils/themes.dart';
import 'state/app_state.dart';
import 'package:provider/provider.dart';

class AlanApp extends StatelessWidget {
  const AlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        // Add more global providers here if needed:
        // ChangeNotifierProvider(create: (_) => ChatProvider()),
        // ChangeNotifierProvider(create: (_) => VoiceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Alan Assistant",
        theme: AlanTheme.light,
        darkTheme: AlanTheme.dark,
        themeMode: ThemeMode.system,
        initialRoute: Routes.home,
        routes: Routes.map,
      ),
    );
  }
}
