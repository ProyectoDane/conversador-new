import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';

/// Delegate for Language Localizations
/// Takes care of providing information on which locales
/// are available and trigger the loading of translations.
class LangLocalizationsDelegate
    extends LocalizationsDelegate<LangLocalizations> {
  /// The Locales our app supports.
  static const Map<String, String> AVAILABLE_LOCALES = <String, String>{
    'en': 'US',
    'es': 'AR',
  };

  /// Function that returns the supported locales in the app
  static Iterable<Locale> supportedLocales() => AVAILABLE_LOCALES.keys
      .map((String key) => Locale(key, AVAILABLE_LOCALES[key]))
      .toList();

  /// Function that returns the list of LocalizationDelegates to be used.
  static List<LocalizationsDelegate<dynamic>> localizationDelegates() =>
      <LocalizationsDelegate<dynamic>>[
        LangLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// Returns the Locale to use.
  static Locale localeResolutionCallback(
      final Locale locale, final Iterable<Locale> supportedLocales) {
    for (final Locale supportedLocale in supportedLocales) {
      // The "?" is necessary because sometimes this method
      // is called twice with locale in null
      if (supportedLocale.languageCode == locale?.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  @override
  bool isSupported(Locale locale) {
    final List<String> locales = AVAILABLE_LOCALES.keys.toList();
    return locales.contains(locale.languageCode);
  }

  @override
  Future<LangLocalizations> load(Locale locale) async =>
      LangLocalizations.load(locale);

  @override
  bool shouldReload(LangLocalizationsDelegate old) => false;
}
