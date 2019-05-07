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
  final String _STAGES_IN_LEVEL_KEY = 'STAGES_IN_LEVEL';

  /// Returns first level of the game
  Future<Level> getFirstLevel(BuildContext context) async {
    await _clearUsedStages();
    return getLevel(1, context);
  }  

  /// Returns the level associated with the given number.
  Future<Level> getLevel(
    int levelId, BuildContext context) async {
    
    final Tuple2<int, bool> levelData = _LEVELS[levelId];
    if (levelData == null) {
      return null;
    }

    final int indexOffset = levelData.item1;
    final bool isRandom = levelData.item2;

    List<Stage> stageList;
    if (isRandom) {
      final List<int> previouslyUsedStages = await _getLevelUsedStageIDs();
      stageList = await _stageRepository.getRandomStagesByCount(
        _maxStageCount, previouslyUsedStages, context);
      await _setLevelUsedStageIDs(stageList);
    } else {
      stageList = await _stageRepository.getStagesByCount(
        _maxStageCount, indexOffset, context);
    }

    if (stageList.isEmpty) {
      return null;
    }
    return Level(stages: stageList, id: levelId);
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

  Future<bool> _setLevelUsedStageIDs(
    List<Stage> stages) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
        _STAGES_IN_LEVEL_KEY,
        stages
            .map((Stage stage) => stage.id.toString())
            .toList());
  }

  Future<List<int>> _getLevelUsedStageIDs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final List<String> difficulties =
          prefs.getStringList(_STAGES_IN_LEVEL_KEY);
      return difficulties.map(int.parse).toList();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return <int>[];
    }
  }

  Future<void> _clearUsedStages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_STAGES_IN_LEVEL_KEY);
  }
}
