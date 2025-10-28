import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro/firebase_options.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/Register/Register.dart';
import 'package:pro/ui/common/App_sharedPreference.dart';
import 'package:pro/ui/common/EventDetails/EventDetails.dart';
import 'package:pro/ui/common/profile/profileScreen.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/home/HomeScreen.dart';
import 'package:pro/ui/home/favScreen.dart';
import 'package:pro/ui/home/mapScreen.dart';
import 'package:pro/ui/login/LoginScreen.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:pro/ui/providers/Theme_provider.dart';
import 'package:pro/ui/providers/language_provider.dart';
import 'package:pro/ui/screens/OnBardeing/IntroScreen.dart';
import 'package:pro/ui/screens/OnBardeing/OnBoardingScreen.dart';
import 'package:pro/ui/screens/addEvent/EditEvent.dart';
import 'package:provider/provider.dart';
import 'package:pro/ui/screens/addEvent/AddEventScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppSharedPreferences.init();
  bool isFirstTime = AppSharedPreferences.getInstance().isOnboarding();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
      ],
      child:  MyApp(isFirstTime: isFirstTime,),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.isFirstTime});
  bool isFirstTime;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);

    String initialRoute;
    if (authProvider.isLoggded()) {
      initialRoute = App_routes.Homescreen.name;
    } else if (isFirstTime) {
      initialRoute = App_routes.OnBoardingScreen.name;
    } else {
      initialRoute = App_routes.LoginScreen.name;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: App_them.lightThem,
      darkTheme: App_them.darkTheme,
      themeMode: provider.getSelectedThemeMode(),
      initialRoute: initialRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageProvider.getSelectedLocale(),
      routes: {
        App_routes.OnBoardingScreen.name: (context) => OnBoardingScreen(),
        App_routes.RegisterScreen.name: (context) => RegisterScreen(),
        App_routes.LoginScreen.name: (context) => LoginScreen(),
        App_routes.Homescreen.name: (context) => Homescreen(),
        App_routes.AddEventScreen.name: (context) => AddEventScreen(),
        App_routes.EventDetails.name: (context) => EventDetails(),
        App_routes.Maps.name: (context) => Maps(),
        App_routes.Favorites.name: (context) => Favorites(),
        App_routes.Profile.name: (context) => Profile(),
        App_routes.EventDetails.name: (context) => EventDetails(),
        App_routes.Edit.name: (context) => EditEvent(),
        App_routes.IntroScreen.name: (context) => IntroScreen(),
      },
    );
  }
}
