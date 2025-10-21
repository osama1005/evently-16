// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get onBoardingScreenTitle => 'خصص تجربتك';

  @override
  String get onBoardingScreenSubtitle =>
      'اختر المظهر واللغة المفضلة لديك لتبدأ بتجربة مريحة ومصممة خصيصًا لتناسب ذوقك.';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get letsStart => 'هيا بنا نبدأ';
}
