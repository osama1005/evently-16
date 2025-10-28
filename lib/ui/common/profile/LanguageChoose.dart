

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';

class LanguageChoose extends StatefulWidget {
  bool isTheme;
  LanguageChoose({super.key, this.isTheme = false});

  @override
  State<LanguageChoose> createState() => _LanguageChooseState();
}

class _LanguageChooseState extends State<LanguageChoose> {
  @override
  Widget build(BuildContext context) {
    LanguageProvider lanProvider = Provider.of<LanguageProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<Locale>(
        value: lanProvider.getSelectedLocale(),
        isExpanded: true,
        underline: const SizedBox(),
        icon: Icon(FontAwesome.arrow_down_solid, color: context.appColors.primary),
        items: [
          DropdownMenuItem(
            value: Locale("ar"),
            child: Text("Arabic", style: context.fonts.bodyLarge?.copyWith(
              color: App_colors.light_primary
            )),
          ),
          DropdownMenuItem(
            value: Locale("en"),
            child: Text("English", style: context.fonts.bodyLarge?.copyWith(
                color: App_colors.light_primary
            )),
          ),
        ],
        onChanged: (value) {
          lanProvider.ChangeLocale(value!);
        },
      ),
    );
  }
}