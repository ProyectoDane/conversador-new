import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';

/// Repository for handling the getting and setting of stages
class StageRepository {
  /// Returns a StageRepository
  factory StageRepository() => _instance;

  StageRepository._internal();

  static final StageRepository _instance = StageRepository._internal();

  // MARK: - Stages
  /// Get a random stage from the ones available for the specified difficulty.
  Future<Stage> getRandomStageForDifficulty(
          int difficulty, BuildContext context) async =>
      StageFactory().getRandomStageOfDifficulty(difficulty, context);

  /// Get all available stages for the specified difficulty.
  Future<List<Stage>> getStagesForDifficulty(
          int difficulty, BuildContext context) async =>
      StageFactory().getStagesOfDifficulty(difficulty, context);

  /// Get a random stage for each of the specified difficulties.
  Future<List<Stage>> getRandomStagesForDifficulties(
      List<int> difficulties, BuildContext context) async {
    final List<Stage> stages = <Stage>[];
    for (final int difficulty in difficulties) {
      stages.add(await getRandomStageForDifficulty(difficulty, context));
    }
    return stages;
  }

  /// Get a certain stage based on its ID
  Future<Stage> getStageFromId(int id, BuildContext context) async =>
      StageFactory().getStageFromId(id, context);
}
