import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LangLocalizations {
  final Locale locale;
  Map<String, String> _strings;

  LangLocalizations(this.locale);

  static LangLocalizations of(final BuildContext context) {
    return Localizations.of<LangLocalizations>(context, LangLocalizations);
  }

  void load() async {
    final String data = await rootBundle.loadString('assets/lang/${this.locale.languageCode}.json');
    final Map<String, dynamic> _result = json.decode(data);

    this._strings = {};
    _result.forEach((String key, dynamic value) {
      this._strings[key] = value.toString();
    });
  }

  String trans(final String key) => this._strings[key];
}
