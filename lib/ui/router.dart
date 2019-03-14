import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/app/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_page.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_page.dart';
import 'package:flutter_syntactic_sorter/app/main/main_page.dart';

class Router {
  static const MAIN_PAGE = '/';
  static const GAME_SETTINGS_PAGE = '/game_settings';
  static const GAME_PAGE = '/game';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      MAIN_PAGE: (BuildContext context) => MainPage(),
      GAME_SETTINGS_PAGE: (BuildContext context) => GameSettingsPage(GameSettingsBloc()),
      GAME_PAGE: (BuildContext context) => GamePage(GameBloc()),
    };
  }
}
