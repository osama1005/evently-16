import 'package:pro/ui/common/App_sharedPreference.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  late Locale _local;
  AppSharedPreferences appStingesPreference = AppSharedPreferences.getInstance();

  LanguageProvider(){
    _local = appStingesPreference.getCurrevtLocale();
  }

  List<Locale> getSupportedLocale(){
    return [
      Locale("en"),
      Locale("ar")
    ];
  }
  Locale getSelectedLocale(){
    return _local ;
  }

  void ChangeLocale(Locale newlang){
    _local = newlang ;
    appStingesPreference.saveLocale(_local);
    notifyListeners();

  }

}