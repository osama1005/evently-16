
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/providers/Theme_provider.dart';
import 'package:provider/provider.dart';


class ThemeChoose extends StatefulWidget {

  bool isTheme;
  ThemeChoose({super.key, this.isTheme = false});

  @override
  State<ThemeChoose> createState() => _ThemeChooseState();
}

class _ThemeChooseState extends State<ThemeChoose> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<ThemeMode>(
        value: themeProvider.getSelectedThemeMode(),
        isExpanded: true,
        underline: const SizedBox(),
        icon: Icon(FontAwesome.arrow_down_solid, color: context.appColors.primary),
        items: [
          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text("Light", style: context.fonts.bodyLarge?.copyWith(
                color: App_colors.light_primary
            )),
          ),
          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text("Dark", style: context.fonts.bodyLarge?.copyWith(
                color: App_colors.light_primary
            )),
          ),
        ],
        onChanged: (value) {
          themeProvider.ChangeTheme(value!);
        },
      ),
    );
  }
}