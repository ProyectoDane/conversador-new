import 'dart:math';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';

class StageRepository {

  static var _instance = StageRepository._internal();

  factory StageRepository() => _instance;

  StageRepository._internal();


  // MARK: - Stages
  Future<Stage> getRandomStage() async {
    final difficulty = Random().nextInt(Stage.DIFFICULTY_MAX) + 1;
    return Future.value(StageFactory.getStage(difficulty));
  }

}