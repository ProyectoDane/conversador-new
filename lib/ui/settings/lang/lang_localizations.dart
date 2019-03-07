import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LangLocalizations {
  final Map<String, String> _strings;

  LangLocalizations._internal(this._strings);

  static LangLocalizations of(final BuildContext context) {
    return Localizations.of<LangLocalizations>(context, LangLocalizations);
  }

  static Future<LangLocalizations> load(Locale locale) async {
    final data = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    final Map<String, dynamic> _result = json.decode(data);
    final strings = _result.map((key, value) => MapEntry(key, value.toString()));
    return LangLocalizations._internal(strings);
  }

  String trans(final String key) => this._strings[key];
}
