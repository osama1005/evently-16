
import 'package:flutter/material.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:provider/provider.dart';

import '../providers/AppAuthprovider.dart';
class Logingoogle extends StatelessWidget {
  const Logingoogle({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: OutlinedButton(
        onPressed: () async {
          await provider.signInWithGoogle();
          Navigator.pushReplacementNamed(context, App_routes.Homescreen.name);
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(16),
          side: BorderSide(
            width: 2,
            color:App_colors.light_primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(App_icons.google, width: 24, height: 24),
            SizedBox(width: 10),
            Text(
              l10n.google,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: App_colors.light_primary
              ),
            ),
          ],
        ),
      ),
    );
  }
}