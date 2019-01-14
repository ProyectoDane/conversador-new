import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/ui/lang/LangLocalizationsDelegate.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/game_page.dart';
import 'package:flutter_syntactic_sorter/ui/pages/main/main_page.dart';

class GameApp extends StatelessWidget {
  final _gameBloc = GameBloc();

  @override
  Widget build(BuildContext context) {
    _setOrientation();

    return MaterialApp(
      title: 'Flutter Syntactic Sorter',
      theme: ThemeData(),
      localizationsDelegates: _localizationDelegates(),
      supportedLocales: LangLocalizationsDelegate.supportedLocales(),
      localeResolutionCallback: _localeResolutionCallback,
      routes: _routes(),
    );
  }

  void _setOrientation() => SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  List<LocalizationsDelegate<dynamic>> _localizationDelegates() => [
        LangLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  Locale _localeResolutionCallback(Locale locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }

  Map<String, WidgetBuilder> _routes() {
    return {
      '/': (BuildContext context) => MainPage(),
      '/game': (BuildContext context) => GamePage(_gameBloc),
    };
  }
}
