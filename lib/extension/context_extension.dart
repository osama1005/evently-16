import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/extension/context_extension.dart';

extension BuildContextExtension on BuildContext{

  ColorScheme get appColors => Theme.of(this).colorScheme ;
  TextTheme get fonts => Theme.of(this).textTheme ;
  AppLocalizations get locals => AppLocalizations.of(this)!;


  void showMessageDialog(
      String message, {
        String? positiveAcButton,
        VoidCallback? positiveActionClick,
        String? negativeAcButton,
        VoidCallback? negativeAcButtonClick,
      }) {
    {
      showDialog(
        context: this,
        builder: (context) {
          var actions = [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                positiveActionClick?.call();
              },
              child: Text(positiveAcButton ?? "Ok"),
            ),
          ];
          if (negativeAcButton != null) {
            actions.add(
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  negativeAcButtonClick?.call();
                },
                child: Text(negativeAcButton),
              ),
            );
          }

          return AlertDialog(
            title: Text("Error", style: context.fonts.titleMedium),
            content: Text(
              message,
              style: context.fonts.titleMedium?.copyWith(
                color: context.appColors.primary,
              ),
            ),
            actions: actions,
          );
        },
      );
    }
  }

  void showLoadingDialog({String? message, bool isDismissible = true}) {
    showDialog(
      context: this,
      builder: (context) {
        return Row(
          children: [
            CircularProgressIndicator(color: Colors.white),
            Text(
              message ?? "Loading...",
              style: context.fonts.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        );
      },
      barrierDismissible: isDismissible,
    );
  }
}

extension DateEx on DateTime {
  String get viewMonthName {
    return DateFormat("MMM").format(this);
  }

  String get formatDate {
    return DateFormat("dd/MM/yyyy").format(this);
  }
}

