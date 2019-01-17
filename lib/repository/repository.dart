import 'dart:math';

import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/utils/stage_factory.dart';
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

  Future<Stage> getRandomStage() async {
    final stage = Random().nextInt(2);
    return Future.value(StageFactory.getStage(stage));
  }
}
