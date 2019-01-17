import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LangLocalizations {
  final Locale locale;
  Map<String, String> _sentences;

  LangLocalizations(this.locale);

  static LangLocalizations of(BuildContext context) {
    return Localizations.of<LangLocalizations>(context, LangLocalizations);
  }

  void load() async {
    String data = await rootBundle.loadString('assets/lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = {};
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });
  }

  String trans(String key) => this._sentences[key];
}
