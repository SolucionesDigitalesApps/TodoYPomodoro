import 'package:flutter/widgets.dart';
import 'package:todo_y_pomodoro_app/core/localization/app_localizations.dart';
import 'package:todo_y_pomodoro_app/core/localization/locales/translations.i69n.dart';

extension BuildContextX on BuildContext {
  String get languageCode => Localizations.localeOf(this).toLanguageTag();

  Translations get translations => AppLocalizations.of(this);
}