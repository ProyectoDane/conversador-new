import 'dart:math';

import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/repository/utils/level_factory.dart';
import 'package:flutter_syntactic_sorter/ui/settings/difficulty/game_difficulty.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  Future<GameDifficulty> getGameDifficulty() async {
    final difficulty = GameDifficulty(
      shapes: Random().nextBool(),
      colors: Random().nextBool(),
    );
    return Future.value(difficulty);
  }

  Future<Level> getRandomLevel() async {
    final level = Random().nextInt(2);
    return Future.value(LevelFactory.getLevel(level));
  }
}
