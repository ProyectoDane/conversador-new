import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

/// Repository for the game Levels.
class LevelRepository {
  /// Creates a LevelRepository based on a stage repository.
  /// The StageRepository must comply to certain requirements:
  /// - The minimum difficulty should be 1
  /// - Every difficulty between the minimum and the maximum
  /// should always have at least one Stage to represent it.
  factory LevelRepository(StageRepository stageRepository) =>
      _instance ??= LevelRepository._internal(stageRepository);

  LevelRepository._internal(StageRepository stageRepository)
      : _stageRepository = stageRepository;

  static LevelRepository _instance;
  final StageRepository _stageRepository;

  // ignore: non_constant_identifier_names, prefer_function_declarations_over_variables
  static final String Function(int) _STAGES_IN_LEVEL_KEY =
      (int number) => 'STAGES_IN_LEVEL.$number';

  /// Returns first level of the game
  Future<Level> getFirstLevel(BuildContext context) async =>
      getLevel(1, context);

  /// Returns the level associated with the given number.
  Future<Level> getLevel(int number, BuildContext context) async {
    final Tuple5<int, int, int, bool, List<int>> info = _LEVELS[number];
    if (info == null) {
      return null;
    }
    final int quantityOfStages = info.item1;
    final int minimumDifficulty = info.item2;
    final int maximumDifficulty = info.item3;
    final bool shouldShuffle = info.item4;
    final List<int> relatedLevels = info.item5;

    List<int> difficulties = List<int>.generate(
        maximumDifficulty - minimumDifficulty + 1,
        (int i) => minimumDifficulty + i);
    // Randomized if necessary
    if (shouldShuffle) {
      difficulties = shuffled(difficulties);
    }
    // Remove already used difficulties
    final List<int> previousUsedDifficulties = <int>[];
    for (final int level in relatedLevels) {
      previousUsedDifficulties
          .addAll(await _getLevelUsedStagesDifficulties(level));
    }
    difficulties.removeWhere(previousUsedDifficulties.contains);
    // Keep the amount of stages needed
    if (difficulties.length > quantityOfStages) {
      difficulties = sampleDownTo(difficulties, quantityOfStages);
    }

    final List<Stage> stages = await _stageRepository
        .getRandomStagesForDifficulties(difficulties, context);

    // Save used difficulties
    await _setLevelUsedStages(stages, number);

    if (stages.isEmpty) {
      return null;
    }
    return Level(stages: stages, number: number);
  }

  // MARK: - Level's parameters
  /// For each level number, you get:
  /// - the quantity of stages to use,
  /// - the min stage difficulty possible to use in this level,
  /// - the max stage difficulty possible to use in this level,
  /// - whether it should order the stages randomly or not,
  /// - the other levels related, from which this level shouldn't
  /// repeat stages difficulties.
  // ignore: non_constant_identifier_names
  final Map<int, Tuple5<int, int, int, bool, List<int>>> _LEVELS =
      <int, Tuple5<int, int, int, bool, List<int>>>{
    1: const Tuple5<int, int, int, bool, List<int>>(5, 1, 5, false, <int>[]),
    2: const Tuple5<int, int, int, bool, List<int>>(5, 6, 10, false, <int>[]),
    3: const Tuple5<int, int, int, bool, List<int>>(5, 1, 10, true, <int>[]),
    4: const Tuple5<int, int, int, bool, List<int>>(5, 1, 10, true, <int>[3]),
  };

  // MARK: - Shared Preferences data

  Future<bool> _setLevelUsedStages(List<Stage> stages, int levelNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_STAGES_IN_LEVEL_KEY(levelNumber),
        stages.map((Stage stage) => stage.difficulty.toString()).toList());
  }

  Future<List<int>> _getLevelUsedStagesDifficulties(int levelNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final List<String> difficulties =
          prefs.getStringList(_STAGES_IN_LEVEL_KEY(levelNumber));
      return difficulties.map(int.parse).toList();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return <int>[];
    }
  }
}
