import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/app/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_page.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_page.dart';
import 'package:flutter_syntactic_sorter/app/main/main_page.dart';

/// Our app Router.
/// Uses uris to identify each screen
/// and create the necessary page.
class Router {
  /// Main / Home page
  static const String MAIN_PAGE = '/';
  /// Page for game settings
  static const String GAME_SETTINGS_PAGE = '/game_settings';
  /// Page for playing the actual game
  static const String GAME_PAGE = '/game';

  /// Returns the whole app routes
  static Map<String, WidgetBuilder> getRoutes() =>
    <String, WidgetBuilder>{
      MAIN_PAGE: (BuildContext context) => const MainPage(),
      GAME_SETTINGS_PAGE: (BuildContext context) =>
          GameSettingsPage(GameSettingsBloc()),
      GAME_PAGE: (BuildContext context) => GamePage(GameBloc()),
    };
}
