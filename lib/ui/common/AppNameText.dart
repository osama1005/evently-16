import 'package:pro/ui/desgin/design.dart';
import 'package:flutter/material.dart';
class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Evently",
      style:Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: App_colors.light_primary) ,);
  }
}
