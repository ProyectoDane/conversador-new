import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class that takes care of loading the translations
/// and return them on demand.
class LangLocalizations {

  LangLocalizations._internal(this._strings);

  /// Builds a LangLocalization based on the context
  static LangLocalizations of(final BuildContext context) =>
    Localizations.of<LangLocalizations>(context, LangLocalizations);

  final Map<String, String> _strings;

  /// Loads the translations for the specified Locale
  /// and returns the prepared LangLocalizations
  static Future<LangLocalizations> load(Locale locale) async {
    final String data = await rootBundle
        .loadString('assets/lang/${locale.languageCode}.json');
    // ignore: avoid_as
    final Map<String, dynamic> _result = json
        .decode(data) as Map<String, dynamic>;
    final Map<String, String> strings = _result
        .map( (String key, dynamic value) =>
          MapEntry<String, String>(key, value.toString())
    );
    return LangLocalizations._internal(strings);
  }

  /// Translates (Localizes) a string.
  String trans(final String key) => _strings[key];

  
}
