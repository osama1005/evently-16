import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:pro/ui/providers/Theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Themes_Switcher extends StatefulWidget {

  Themes_Switcher(){

  }
  @override
  State<Themes_Switcher> createState() => _Themes_SwitcherState();

}

class _Themes_SwitcherState extends State<Themes_Switcher> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider =Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch<ThemeMode>.rolling(
      current: provider.getSelectedThemeMode() ,
     values: provider.getMode(),
    onChanged: (newThemeMode) {
      setState(() {
        provider.ChangeTheme(newThemeMode);
      });
    },
    iconBuilder: (value, foreground) {
      if(value == ThemeMode.light){
       return Icon(EvaIcons.sun,size: 24,);
    }
      else{
        return Icon(EvaIcons.moon,size: 24,);
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
