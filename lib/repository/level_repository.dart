import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/stage_app_repository.dart';
//import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tuple/tuple.dart';

/// Repository for the game Levels.
class LevelRepository {
  /// Creates a LevelRepository based on a stage repository.
  /// The StageRepository must comply to certain requirements:
  /// - The minimum difficulty should be 1
  /// - Every difficulty between the minimum and the maximum
  /// should always have at least one Stage to represent it.
  factory LevelRepository(StageAppRepository stageRepository) =>
      _instance ??= LevelRepository._internal(stageRepository);

  LevelRepository._internal(StageAppRepository stageRepository)
      : _stageRepository = stageRepository;

  static LevelRepository _instance;
  final StageAppRepository _stageRepository;

  // ignore: non_constant_identifier_names, prefer_function_declarations_over_variables
  static final String Function(int) _STAGES_IN_LEVEL_KEY =
      (int number) => 'STAGES_IN_LEVEL.$number';

  /// Returns first level of the game
  Future<Level> getFirstLevel(BuildContext context) async =>
      getLevel(1, context);

  /// Returns the level associated with the given number.
  Future<Level> getLevel(int complexityLevel, BuildContext context) async {

    final List<Stage> stages = await _stageRepository
        .getStagesForDifficulty(complexityLevel, context);
    // Incoming levels could be mixed with custom levels 
    // They are sorted by sublevel
    stages.sort((Stage stage1,Stage stage2)
      => stage1.subLevel.compareTo(stage2.subLevel)
    );

    // Save used difficulties
    await _setLevelUsedStages(stages, complexityLevel);

    if (stages.isEmpty) {
      return null;
    }
    return Level(stages: stages, id: complexityLevel);
  }

   // MARK: - Level's parameters
  /// For each level number, you get:
  /// - The dificulty rating,
  /// - Whether or not they are randomized,
  // final Map<int, Tuple2<int, bool>> _LEVELS =
  //     <int, Tuple2<int, bool>>{
  //   1: const Tuple2<int, bool>(1, false),
  //   2: const Tuple2<int, bool>(2, false),
  //   3: const Tuple2<int, bool>(3, false),
  //   4: const Tuple2<int, bool>(4, false),
  // };

  // MARK: - Shared Preferences data

  Future<bool> _setLevelUsedStages(List<Stage> stages, int levelNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
        _STAGES_IN_LEVEL_KEY(levelNumber),
        stages
            .map((Stage stage) => stage.mentalComplexity.toString())
            .toList());
  }

  // Future<List<int>> _getLevelUsedStagesDifficulties(int levelNumber) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     final List<String> difficulties =
  //         prefs.getStringList(_STAGES_IN_LEVEL_KEY(levelNumber));
  //     return difficulties.map(int.parse).toList();
  //     // ignore: avoid_catches_without_on_clauses
  //   } catch (e) {
  //     return <int>[];
  //   }
  // }
}
