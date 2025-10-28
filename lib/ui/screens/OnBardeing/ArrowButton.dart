import 'package:flutter/material.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/desgin/design.dart';

class ArrowButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const ArrowButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(365),
          color: Colors.transparent,
          border: Border.all(color: context.appColors.primary),
        ),
        child: Icon(icon, color:context.appColors.primary),
      ),
    );
  }
}