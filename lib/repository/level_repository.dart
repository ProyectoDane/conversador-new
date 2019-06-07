import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';
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
  final String _STAGES_IN_LEVEL_KEY = 'STAGES_IN_LEVEL';
  // ignore: non_constant_identifier_names, prefer_function_declarations_over_variables
  final String _STAGE_TRACKING_KEY = 'STAGE_TRACKING';

  /// Returns first level of the game
  Future<Level> getFirstLevel() async {
    await _clearUsedStages();
    await _clearStageTrackingIndexes();
    return getLevel(1);
  }  

  /// Returns the level associated with the given number.
  Future<Level> getLevel(
    int levelId) async {
    
    final Tuple2<int, bool> levelData = _LEVELS[levelId];
    if (levelData == null) {
      return null;
    }

    final int stageCount = levelData.item1;
    final bool isRandom = levelData.item2;

    List<Stage> stageList;
    if (isRandom) {
      final List<int> previouslyUsedStages = await _getLevelUsedStageIDs();
      stageList = await _stageRepository.getRandomStagesByCount(
        stageCount, previouslyUsedStages);
      await _setLevelUsedStageIDs(stageList);
    } else {
      final Tuple2<int, int> trackingIndexes = await _getStageTrackingIndexes();
      final int currentStageComplexity = trackingIndexes.item1;
      final int nextStageInComplexityIndex = trackingIndexes.item2;
      stageList = await _stageRepository.getStageList(
        stageCount, currentStageComplexity, nextStageInComplexityIndex);
      await _setStageTrackingIndexes(stageList.last);
    }

    if (stageList.isEmpty) {
      return null;
    }

    return Level(
      stages: stageList, id: levelId);
  }

  /// Check if level is final level
  bool isFinalLevel(int levelId) 
    => levelId == _LEVELS.values.length;
  
  // MARK: - Level's parameters
  /// For each level number, you get:
  /// - The stage count,
  /// - Whether or not they are randomized,
  // ignore: prefer_function_declarations_over_variables, non_constant_identifier_names
  final Map<int, Tuple2<int, bool>> _LEVELS =
      <int, Tuple2<int, bool>>{
    1: const Tuple2<int, bool>(5, false),
    2: const Tuple2<int, bool>(5, false),
    3: const Tuple2<int, bool>(5, true),
    4: const Tuple2<int, bool>(5, true),
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

  Future<void> _setStageTrackingIndexes(Stage lastStage) async {
    final int currentStageComplexity = lastStage.mentalComplexity.index;
    final int nextStageInComplexityIndex = lastStage.complexityOrder + 1;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> indexStrings = 
      <String>[currentStageComplexity.toString(), 
               nextStageInComplexityIndex.toString()];
    await prefs.setStringList(
        _STAGE_TRACKING_KEY, indexStrings);
  }

  Future<Tuple2<int, int>> _getStageTrackingIndexes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final List<String> indexesStrings = 
        prefs.getStringList(_STAGE_TRACKING_KEY);
      final List<int> indexes = indexesStrings.map(int.parse).toList();
      return Tuple2<int, int>(indexes[0], indexes[1]);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return const Tuple2<int, int>(0, 0);
    }
  }

  Future<void> _clearStageTrackingIndexes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_STAGE_TRACKING_KEY);
  }
}
