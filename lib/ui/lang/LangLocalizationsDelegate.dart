import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/lang/LangLocalizations.dart';

class LangLocalizationsDelegate extends LocalizationsDelegate<LangLocalizations> {
  final List<String> _locales = ['es', 'en'];

  static Iterable<Locale> supportedLocales() => [
        const Locale('en', 'US'),
        const Locale('es', 'AR'),
      ];

  @override
  bool isSupported(Locale locale) => this._locales.contains(locale.languageCode);

  @override
  Future<LangLocalizations> load(Locale locale) async {
    LangLocalizations localizations = LangLocalizations(locale);
    localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LangLocalizationsDelegate old) => false;
}
