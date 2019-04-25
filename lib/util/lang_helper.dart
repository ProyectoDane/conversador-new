import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

/// Language Code shared preferences key
const String _language_code_key = 'language_code';

/// Returns the locale of the device
Future<Locale> fetchLocale() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await _setLocale(prefs);

  return Locale(prefs.getString(_language_code_key));
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> _setLocale(SharedPreferences prefs) async {
  String currentLocale;
  String cacheLocale;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocale = (await Devicelocale.currentLocale).substring(0, 2);
    cacheLocale = prefs.getString(_language_code_key);
    if (currentLocale != cacheLocale) {
      await prefs.setString(_language_code_key, currentLocale);
    }
  } on PlatformException {
    print('Error obtaining current locale');
  }
}
