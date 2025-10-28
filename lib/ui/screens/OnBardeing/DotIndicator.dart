import 'package:flutter/material.dart';
import 'package:pro/extension/context_extension.dart';

// ignore: must_be_immutable
class DotIndicator extends StatelessWidget {
  bool isSelected;
  DotIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isSelected ? 21 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isSelected ? context.appColors.primary : context.appColors.primary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(365),
      ),

    );
  }
}