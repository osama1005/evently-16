
import 'package:flutter/material.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/desgin/design.dart';

import 'OnBoardingData.dart';

class PageViewItem extends StatelessWidget {
  final OnBoardingData data;
  const PageViewItem({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(data.image),
        SizedBox(height: 39),
        Text(
          data.title,
          style: context.fonts.bodyLarge?.copyWith(
            color: App_colors.light_primary
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 30),
        Expanded(
          child: Text(data.description, style: TextStyle(
            fontSize: 16,color: Colors.black
          )),
        ),
      ],
    );
  }
}