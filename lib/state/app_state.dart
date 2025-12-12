import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // ------------------------------------------------------------
  // GLOBAL THEME MODE (mirrors SettingsProvider)
  // ------------------------------------------------------------
  bool _darkMode = true;

  bool get darkMode => _darkMode;

  set darkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // APP-LEVEL FLAGS
  // ------------------------------------------------------------
  bool _isFirstLaunch = false;

  bool get isFirstLaunch => _isFirstLaunch;

  void setFirstLaunch(bool value) {
    _isFirstLaunch = value;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // GLOBAL LOADING FLAG (optional)
  // useful for app-wide background tasks
  // ------------------------------------------------------------
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // METHOD: Sync theme mode from SettingsProvider
  // ------------------------------------------------------------
  void applyTheme(bool isDark) {
    _darkMode = isDark;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // CLEAR APP STATE (rarely used)
  // ------------------------------------------------------------
  void reset() {
    _darkMode = true;
    _isBusy = false;
    _isFirstLaunch = false;
    notifyListeners();
  }
}
