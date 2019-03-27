import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LangLocalizations {

  LangLocalizations._internal(this._strings);

  static LangLocalizations of(final BuildContext context) =>
    Localizations.of<LangLocalizations>(context, LangLocalizations);

  final Map<String, String> _strings;

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

  String trans(final String key) => _strings[key];
}
