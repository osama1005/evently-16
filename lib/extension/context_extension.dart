import 'package:flutter/material.dart';
import 'package:pro/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext{

  ColorScheme get appColors => Theme.of(this).colorScheme ;
  TextTheme get fonts => Theme.of(this).textTheme ;
  AppLocalizations get locals => AppLocalizations.of(this)!;
}