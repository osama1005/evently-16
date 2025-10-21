import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro/firebase_options.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/common/App_sharedPreference.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/login/LoginScreen.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:pro/ui/providers/Theme_provider.dart';
import 'package:pro/ui/providers/language_provider.dart';
import 'package:pro/ui/screens/OnBardeing/OnBoardingScreen.dart';
import 'package:provider/provider.dart';




void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await AppSharedPreferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>ThemeProvider()),
      ChangeNotifierProvider(create: (_)=>LanguageProvider()),
      ChangeNotifierProvider(create: (_)=>Appauthprovider())

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: App_them.lightThem,
      darkTheme: App_them.darkTheme,
      themeMode:provider.getSelectedThemeMode(),
      initialRoute: App_routes.LoginScreen.route,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales:AppLocalizations.supportedLocales,
      locale: languageProvider.getSelectedLocale(),
      routes: {
        App_routes.OnBoardingScreen.route: (context) => OnBoardingScreen(),
        App_routes.LoginScreen.route : (context)=> LoginScreen(),
    },
    );
  }
}
