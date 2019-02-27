import 'dart:math';

import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  // TODO save the config
  List<GameDifficulty> difficulties;

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  // TODO in the future it will return a value if it was properly saved
  Future<bool> setShapeConfig(final List<GameDifficulty> difficulties) async {
    this.difficulties = difficulties;
    return Future.value(true);
  }

  Future<ShapeConfig> getShapeConfig() async {
    final shapeConfig = ShapeConfig.getDefaultConfig();
    final shapeConfigWithDifficulties = ShapeConfig.applyDifficulties(shapeConfig, difficulties);
    return Future.value(shapeConfigWithDifficulties);
  }

  Future<Stage> getRandomStage() async {
    final difficulty = Random().nextInt(Stage.DIFFICULTY_MAX) + 1;
    return Future.value(StageFactory.getStage(difficulty));
  }
}
