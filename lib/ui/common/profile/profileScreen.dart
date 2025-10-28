
import 'package:flutter/material.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';

import 'package:provider/provider.dart';

import 'LanguageChoose.dart';
import 'ThemeChoose.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color:context.appColors.primary,
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(64),
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.20,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(App_icons.route),
                      ),
                      color: context.appColors.primary,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(365),
                        bottomStart: Radius.circular(365),
                        topEnd: Radius.circular(365),
                        topStart: Radius.circular(12),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        provider.getUser()?.name ?? "",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(
                        provider.getUser()?.email ?? "",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                  l10n.language,
                  style: context.fonts.bodySmall
              ),
            ),
            LanguageChoose(),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                l10n.theme,
                style: context.fonts.bodySmall,
              ),
            ),
            ThemeChoose(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  provider.logout();
                  Navigator.pushReplacementNamed(context,App_routes.Homescreen.name);
                },
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(Icons.logout, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      l10n.logout,
                      style: context.fonts.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}