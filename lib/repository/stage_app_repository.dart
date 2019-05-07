import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';

/// Repository for handling the getting and setting of stages
class StageAppRepository {
  /// Returns a StageRepository
  factory StageAppRepository() => _instance;

  StageAppRepository._internal();

  static final StageAppRepository _instance = StageAppRepository._internal();

  // MARK: - Stages
  /// Get a random stage from the ones available for the specified difficulty.
  Future<Stage> getRandomStageForComplexity(
          Complexity difficulty, BuildContext context) async =>
      StageFactory().getRandomStageOfComplexity(difficulty, context);

  /// Get all available stages for the specified difficulty.
  Future<List<Stage>> getStagesForComplexity(
          Complexity difficulty, BuildContext context) async =>
      StageFactory().getStagesOfComplexity(difficulty, context);

  /// Get a number of Stages from the list with difficulty in ascending order.
  Future<List<Stage>> getStagesByCount(
    int count, int indexOffset, BuildContext context) async =>
    StageFactory().getStagesByCount(count, indexOffset, context);

  /// Get a random stage for each of the specified difficulties.
  Future<List<Stage>> getRandomStagesForComplexity(
      List<Complexity> difficulties, BuildContext context) async {
    final List<Stage> stages = <Stage>[];
    for (final Complexity difficulty in difficulties) {
      stages.add(await getRandomStageForComplexity(difficulty, context));
    }
    return stages;
  }

  /// Get a certain stage based on its ID
  Future<Stage> getStageFromId(int id, BuildContext context) async =>
      StageFactory().getStageFromId(id, context);
}
