import 'dart:math';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';

class StageRepository {

  factory StageRepository() => _instance;

  StageRepository._internal();

  static final StageRepository _instance = StageRepository._internal();

  // MARK: - Stages
  Future<Stage> getRandomStage() async {
    final int difficulty = Random().nextInt(Stage.DIFFICULTY_MAX) + 1;
    return Future<Stage>.value(StageFactory.getStage(difficulty));
  }

}