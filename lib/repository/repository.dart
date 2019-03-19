import 'dart:math';

import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  // TODO save the config
  List<GameDifficulty> difficulties = List();

  factory Repository() => _instance;

  Repository.internal();

  // TODO in the future it will return a value if it was properly saved
  Future<bool> setPieceConfig(final List<GameDifficulty> difficulties) async {
    this.difficulties = difficulties;
    return Future.value(true);
  }

  Future<PieceConfig> getPieceConfig() async {
    final pieceConfig = PieceConfig.getDefaultConfig();
    final pieceConfigWithDifficulties = PieceConfig.applyDifficulties(pieceConfig, difficulties);
    return Future.value(pieceConfigWithDifficulties);
  }

  Future<Stage> getRandomStage() async {
    final difficulty = Random().nextInt(Stage.DIFFICULTY_MAX) + 1;
    return Future.value(StageFactory.getStage(difficulty));
  }
}
