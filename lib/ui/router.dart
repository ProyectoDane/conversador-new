import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_bloc.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/game_page.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game_settings/game_settings_page.dart';
import 'package:flutter_syntactic_sorter/ui/pages/main/main_page.dart';

class Router {
  static const MAIN_PAGE = '/';
  static const GAME_SETTINGS_PAGE = '/game_settings';
  static const GAME_PAGE = '/game';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      MAIN_PAGE: (BuildContext context) => MainPage(MainBloc()),
      GAME_SETTINGS_PAGE: (BuildContext context) => GameSettingsPage(GameSettingsBloc()),
      GAME_PAGE: (BuildContext context) => GamePage(GameBloc()),
    };
  }
}
