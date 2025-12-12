import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider()..loadConfig(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ----------------------------------------------------
          // API ENDPOINT
          // ----------------------------------------------------
          _SettingSection(
            title: "Backend API Endpoint",
            child: TextField(
              controller: settings.endpointCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: _inputStyle("https://your-server.com/v1/chat"),
            ),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // LIVEKIT URL
          // ----------------------------------------------------
          _SettingSection(
            title: "LiveKit URL",
            child: TextField(
              controller: settings.livekitUrlCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: _inputStyle("wss://example.livekit.cloud"),
            ),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // LIVEKIT KEY
          // ----------------------------------------------------
          _SettingSection(
            title: "LiveKit API Key",
            child: TextField(
              controller: settings.livekitKeyCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: _inputStyle("••••••••••••"),
            ),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // LIVEKIT SECRET
          // ----------------------------------------------------
          _SettingSection(
            title: "LiveKit API Secret",
            child: TextField(
              controller: settings.livekitSecretCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: _inputStyle("••••••••••••"),
            ),
          ),

          const SizedBox(height: 30),

          // ----------------------------------------------------
          // THEME MODE TOGGLE
          // ----------------------------------------------------
          SwitchListTile(
            title: const Text(
              "Dark Mode",
              style: TextStyle(color: Colors.white),
            ),
            value: settings.darkMode,
            onChanged: (v) => settings.setDarkMode(v),
            activeColor: Colors.blueAccent,
          ),

          const SizedBox(height: 40),

          // ----------------------------------------------------
          // SAVE BUTTON
          // ----------------------------------------------------
          ElevatedButton(
            onPressed: settings.isSaving ? null : () => settings.saveConfig(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.withOpacity(.9),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: settings.isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    "Save Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Shared textfield style
  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withOpacity(.4)),
      filled: true,
      fillColor: Colors.white.withOpacity(.06),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(.1)),
      ),
    );
  }
}

// ----------------------------------------------------
// SETTINGS SECTION HEADER + WRAPPER
// ----------------------------------------------------
class _SettingSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(.8),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
