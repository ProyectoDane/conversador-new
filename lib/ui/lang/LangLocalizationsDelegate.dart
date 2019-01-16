import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/lang/LangLocalizations.dart';

class LangLocalizationsDelegate extends LocalizationsDelegate<LangLocalizations> {
  static const Map<String, String> AVAILABLE_LOCALES = {
    'en': 'US',
    'es': 'AR',
  };

  static Iterable<Locale> supportedLocales() {
    return AVAILABLE_LOCALES.keys.map((key) {
      return Locale(key, AVAILABLE_LOCALES[key]);
    }).toList();
  }

  static List<LocalizationsDelegate<dynamic>> localizationDelegates() => [
        LangLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static Locale localeResolutionCallback(Locale locale, Iterable<Locale> supportedLocales) {
    // This is necessary because sometimes it's called twice with locale in null
    if (locale == null) {
      return supportedLocales.first;
    }

    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }

  @override
  bool isSupported(Locale locale) {
    List<String> locales = AVAILABLE_LOCALES.keys.toList();
    return locales.contains(locale.languageCode);
  }

  @override
  Future<LangLocalizations> load(Locale locale) async {
    LangLocalizations localizations = LangLocalizations(locale);
    localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LangLocalizationsDelegate old) => false;
}
