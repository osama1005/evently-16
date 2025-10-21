import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String themeKey = "themeKey";
  static const String light = "light";
  static const String dark = "dark";

  late SharedPreferences _sharedPreferences;

  AppSharedPreferences._();

  static AppSharedPreferences? _appSharedPreferences;

  static AppSharedPreferences getInstance() {
    return _appSharedPreferences!;
  }

  static Future<void> init() async {
    if (_appSharedPreferences == null) {
      _appSharedPreferences = AppSharedPreferences._();
      await _appSharedPreferences?.initialize();
    }
  }

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveThemeMode(ThemeMode newTheme) async {
    var theme = newTheme == ThemeMode.light ? light : dark;

    await _sharedPreferences.setString(themeKey, theme);
  }

  ThemeMode getThemeMode() {
    var themeName = _sharedPreferences.getString(themeKey);

    return themeName == dark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> saveLocale(Locale local) async{
   await _sharedPreferences.setString("locale", local.languageCode);

  }

  Locale getCurrevtLocale() {
    var langCode = _sharedPreferences.getString("locale");
    return langCode==null ? Locale("en")
        : Locale.fromSubtags(languageCode: langCode);



  }



}