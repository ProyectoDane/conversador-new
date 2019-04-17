import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntactic_sorter/router.dart';
import 'package:flutter_syntactic_sorter/src/fixtures.dart' show printDB;
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations_delegate.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Our Application main Widget
class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // *Just for testing* Print the database
    printDB();
    // Set orientation to landscape
    _setOrientation();

    return MaterialApp(
      title: 'Flutter Syntactic Sorter',
      theme: _getTheme(),
      localizationsDelegates: LangLocalizationsDelegate.localizationDelegates(),
      supportedLocales: LangLocalizationsDelegate.supportedLocales(),
      localeResolutionCallback:
          LangLocalizationsDelegate.localeResolutionCallback,
      routes: Router.getRoutes(),
    );
  }

  void _setOrientation() =>
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);

  ThemeData _getTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        headline:
            TextStyle(fontSize: Dimen.FONT_HUGE, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: Dimen.FONT_BIG, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: Dimen.FONT_NORMAL, fontFamily: 'Hind'),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.lightGreen,
            fontStyle: FontStyle.italic,
            fontSize: Dimen.FONT_BIG),
        contentTextStyle: TextStyle(
            color: Colors.black54,
            fontFamily: 'Hind',
            fontSize: Dimen.FONT_NORMAL),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      ));
}
