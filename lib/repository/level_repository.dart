import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/stage_app_repository.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

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
  final int _maxStageCount = 5;

  // ignore: non_constant_identifier_names, prefer_function_declarations_over_variables
  static final String Function(int) _STAGES_IN_LEVEL_KEY =
      (int number) => 'STAGES_IN_LEVEL.$number';

  /// Returns first level of the game
  Future<Level> getFirstLevel(BuildContext context) async =>
      getLevel(1, context);

  /// Returns the level associated with the given number.
  Future<Level> getLevel(
    int levelId, BuildContext context) async {
    
    final Tuple2<int, bool> levelData = _LEVELS[levelId];
    final int indexOffset = levelData.item1;
    final bool isRandom = levelData.item2;

    if (isRandom) {
      
    } else {
      final List<Stage> stageList = await _stageRepository.getStagesByCount(
        _maxStageCount, indexOffset, context);
      return Level(stages: stageList, id: levelId);
    }

    final List<Stage> stages = await _stageRepository
        .getStagesForComplexity(levelId as Complexity, context);
    // Incoming levels could be mixed with custom levels 
    // They are sorted by sublevel
    stages.sort((Stage stage1,Stage stage2)
      => stage1.complexityOrder.compareTo(stage2.complexityOrder)
    );

    // Save used difficulties
    await _setLevelUsedStages(stages, levelId);

    if (stages.isEmpty) {
      return null;
    }
    return Level(stages: stages, id: levelId);
  }

  // MARK: - Level's parameters
  /// For each level number, you get:
  /// - The stage list offset,
  /// - Whether or not they are randomized,
  final Map<int, Tuple2<int, bool>> _LEVELS =
      <int, Tuple2<int, bool>>{
    1: const Tuple2<int, bool>(0, false),
    2: const Tuple2<int, bool>(5, false),
    3: const Tuple2<int, bool>(0, true),
    4: const Tuple2<int, bool>(0, true),
  };
  
  // MARK: - Shared Preferences data

  Future<bool> _setLevelUsedStages(
    List<Stage> stages, int levelNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
        _STAGES_IN_LEVEL_KEY(levelNumber),
        stages
            .map((Stage stage) => stage.mentalComplexity.toString())
            .toList());
  }

  Future<List<int>> _getLevelUsedStages(int levelNumber) async {
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
