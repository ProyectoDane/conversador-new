import 'dart:math';

import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/utils/stage_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  // TODO improve this
  void setShapeConfig(List<GameDifficulty> difficulties) async {}

  Future<ShapeConfig> getShapeConfig() async {
    final shapeConfig = ShapeConfig.getDefaultConfig();
    final difficulties = [ShapeDifficulty(), ColorDifficulty()];
    final shapeConfigWithDifficulties = ShapeConfig.applyDifficulties(shapeConfig, difficulties);
    return Future.value(shapeConfigWithDifficulties);
  }

  Future<Stage> getRandomStage() async {
    final stage = Random().nextInt(2);
    return Future.value(StageFactory.getStage(stage));
  }
}
