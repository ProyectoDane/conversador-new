import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/game_page.dart';

class GameApp extends StatelessWidget {
  final _gameBloc = GameBloc();

  @override
  Widget build(BuildContext context) {
    _setOrientation();

    return MaterialApp(
      title: 'Flutter Syntactic Sorter',
      theme: ThemeData(),
      routes: {
        '/': (BuildContext context) => GamePage(_gameBloc),
      },
    );
  }

  void _setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
