import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scanningapp/services/local_db.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  PreferencesServices preferencesServices = PreferencesServices();

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  ThemeMode toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;

    preferencesServices.setDarkMode(isOn);

    notifyListeners();
    return themeMode;
  }
}
