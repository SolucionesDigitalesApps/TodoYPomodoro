import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:todo_y_pomodoro_app/core/localization/locales/translations.i69n.dart';
import 'package:todo_y_pomodoro_app/core/localization/locales/translations_es.i69n.dart';

final _translations = <String, Translations Function()>{
  'en': () => const Translations(),
  'es': () => const Translations_es(),
};

class AppLocalizations {
  AppLocalizations(this.translations);

  final Translations translations;

  static final _setLocaleController = StreamController<Locale>.broadcast();
  static Function(Locale) get setLocaleSink => _setLocaleController.sink.add;
  static Stream<Locale> get setLocaleStream => _setLocaleController.stream;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final List<Locale> supportedLocales =
      _translations.keys.map((x) => Locale(x)).toList();


  static Translations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!
          .translations;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _translations.keys.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      Future.value(AppLocalizations(_translations[locale.languageCode]!()));

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}