import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations_delegate.dart';

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _setOrientation();

    return MaterialApp(
      title: 'Flutter Syntactic Sorter',
      theme: _getTheme(),
      localizationsDelegates: LangLocalizationsDelegate.localizationDelegates(),
      supportedLocales: LangLocalizationsDelegate.supportedLocales(),
      localeResolutionCallback: LangLocalizationsDelegate.localeResolutionCallback,
      routes: Router.getRoutes(),
    );
  }

  void _setOrientation() => SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);

  ThemeData _getTheme() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
      );
}
