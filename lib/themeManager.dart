import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = ThemeData();
  ThemeData getTheme() => _themeData;

  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );


  void setMobileTheme(BuildContext context) async {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    // var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      print("Dark Mode");
      _themeData = darkTheme;
    } else {
      print("Light Mode");
      _themeData = lightTheme;
    }
  }

  void setDarkMode() async {
    print("Dark Mode");
    _themeData = darkTheme;
    // StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    print("Light Mode");
    _themeData = lightTheme;
    //  StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
