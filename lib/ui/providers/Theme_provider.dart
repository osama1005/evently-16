import 'package:flutter/material.dart';
import 'package:pro/ui/common/App_sharedPreference.dart';

class ThemeProvider extends ChangeNotifier{
  late ThemeMode _themeMode;
  AppSharedPreferences appStingesPreference = AppSharedPreferences.getInstance();

  ThemeProvider(){
    _themeMode = appStingesPreference.getThemeMode();
  }

  List<ThemeMode> getMode(){
    return [
      ThemeMode.light,
      ThemeMode.dark,
    ];
  }
  ThemeMode getSelectedThemeMode(){
    return _themeMode ;
  }

  void ChangeTheme(ThemeMode newMode){
    appStingesPreference.saveThemeMode(newMode);
    _themeMode = newMode ;
    notifyListeners();

  }

}