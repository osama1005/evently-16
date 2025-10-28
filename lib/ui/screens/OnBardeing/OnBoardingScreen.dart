import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/common/AppNameText.dart';
import 'package:pro/ui/common/Language_switch.dart';
import 'package:pro/ui/common/Theme_switch.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(App_icons.app_logo),
            SizedBox(width: 10),
            AppNameText(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Image.asset(App_icons.onBoarding1)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.onBoardingTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.onBoardingTitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      LanguageSwitch(),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.theme,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Themes_Switcher(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, App_routes.IntroScreen.name);
                      },
                      child: Text(AppLocalizations.of(context)!.letsStart,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

