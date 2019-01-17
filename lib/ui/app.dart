import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/game_page.dart';
import 'package:flutter_syntactic_sorter/ui/pages/main/main_page.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/LangLocalizationsDelegate.dart';

class GameApp extends StatelessWidget {
  final _gameBloc = GameBloc();

  @override
  Widget build(BuildContext context) {
    _setOrientation();

    return MaterialApp(
      title: 'Flutter Syntactic Sorter',
      theme: ThemeData(),
      localizationsDelegates: LangLocalizationsDelegate.localizationDelegates(),
      supportedLocales: LangLocalizationsDelegate.supportedLocales(),
      localeResolutionCallback: LangLocalizationsDelegate.localeResolutionCallback,
      routes: _routes(),
    );
  }

  void _setOrientation() => SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);

  Map<String, WidgetBuilder> _routes() {
    return {
      '/': (BuildContext context) => MainPage(),
      '/game': (BuildContext context) => GamePage(_gameBloc),
    };
  }
}
