import 'package:pro/ui/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart';


class LanguageSwitch extends StatefulWidget {

@override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State <LanguageSwitch>{

@override
  Widget build(BuildContext context) {
  LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return AnimatedToggleSwitch<Locale>.rolling(
      current: languageProvider.getSelectedLocale(),
      values:languageProvider.getSupportedLocale(),
      onChanged: (item) {
        setState(() {
          languageProvider.ChangeLocale(item);
        });
      },
      iconBuilder: (value, foreground) {
        if(value == Locale("en")){
          return Flag(Flags.united_states_of_america,
          size: 24,
          );
      }else {
          return Flag(Flags.egypt,
            size: 24,
          );
        }
        },
      style:ToggleStyle(
        indicatorColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        borderColor: Theme.of(context).colorScheme.primary,
      ),

    );

  }
}
