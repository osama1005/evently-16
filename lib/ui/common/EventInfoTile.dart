
import 'package:flutter/material.dart';
import 'package:pro/extension/context_extension.dart';


class EventInfoTile extends StatelessWidget {
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String text;
  const EventInfoTile({
    super.key,
    required this.prefixIcon,
    this.suffixIcon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: context.appColors.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.appColors.primary,
                  ),
                  child: Icon(prefixIcon, color: Colors.white),
                ),
                SizedBox(width: 8),
                Text(
                  overflow: TextOverflow.ellipsis,
                  text,
                  style: context.fonts.titleMedium?.copyWith(
                    color: context.appColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Icon(suffixIcon, color: context.appColors.primary),
        ],
      ),
    );
  }
}