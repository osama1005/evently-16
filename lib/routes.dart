import 'package:flutter/material.dart';
enum App_routes{
  HomeScreen("home"),
  OnBoardingScreen("onBoarding"),
  RegisterScreen("register"),
  LoginScreen("login"),
  ;


  final String route;
  const App_routes(this.route);
}