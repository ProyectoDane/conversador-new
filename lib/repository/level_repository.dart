import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/implementation/level_database_repository.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

/// How level generation works:
/// The Level objects don't actually know which stages they'll contain, they 
/// only know how many stages they have and whether or not they are random.
/// The stages, when requested to the DB (_stageRepository.getPlainStageList), 
/// are obtained in ascending order order. The first time I request the list:
/// 
/// _stageRepository.getPlainStageList(
///   levelCount: 5,
///   complexity: 0,
///   order: 0
/// 
/// this would be the result:
///
/// [Stage complx:1 - Order 0
///  Stage complx:1 - Order 2
///  ...
///  Stage complx:2 - Order 0]
///
/// By looking at the last stage, I know that the next time I ask for another 
/// 5 stages, I'll start from complexity 2, order 1.
/// When the user ends the game, the registry is reset.
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
    return getLevel(0);
  }  

  /// Returns level that contains stage and the index where said stage
  /// is placed, if not found returns null
  /// Item 1 : Level
  /// Item 2 : Stage index within list inside Level
  Future<Tuple2<Level, int>> getLevelWithStageId(int stageId) async {
    await _clearUsedStages();
    await _clearStageTrackingIndexes();

    const int levelId = 0;
    // Starts iterating over levels
    return _searchThroughLevelsFor(levelId, stageId);
  }

  Future<Tuple2<Level, int>>_searchThroughLevelsFor(
    int levelId, int stageId) async {
    final DatabaseProvider databaseProvider = DatabaseProvider();
    final Level level = await LevelDatabaseRepository(
      databaseProvider).getById(levelId);
    
    if (level == null) {
      return null;
    }

    // We are looking in non-random levels
    if (!level.isRandom) {
      final Tuple2<int, int> trackingIndexes = await _getStageTrackingIndexes();
      final int currentStageComplexity = trackingIndexes.item1;
      final int nextStageInComplexityIndex = trackingIndexes.item2;
      // This line just gets the plain stage list without the sentence data, 
      // it's faster than the other one because it doesn't do additional querys
      level.stages = await _stageRepository.getPlainStageList(
        level.stageCount, currentStageComplexity, nextStageInComplexityIndex);
      await _setStageTrackingIndexes(level.stages.last);

      // Check if stage is found in this level
      final Stage foundStage = level.stages.singleWhere(
        (Stage stage) => stage.id == stageId, orElse:() => null);
      if (foundStage != null) {
        final int stageIndex = level.stages.indexOf(foundStage);
        // If this is the level, then we can fill in the rest 
        // of the sentence data
        level.stages = await _stageRepository.fillInStageData(level.stages);
        return Tuple2<Level, int>(level, stageIndex);
      } else {
        // If not move on to the next level
        return _searchThroughLevelsFor(levelId + 1, stageId);
      }
    } else {
      // Once we reach the random levels, there no more stages to sort through
      return null;
    }
  }

  /// Returns the level associated with the given number.
  Future<Level> getLevel(
    int levelId) async {

    final DatabaseProvider databaseProvider = DatabaseProvider();
    final Level level = await LevelDatabaseRepository(
      databaseProvider).getById(levelId);
    
    if (level == null) {
      return null;
    }

    if (level.isRandom) {
      final List<int> previouslyUsedStages = await _getLevelUsedStageIDs();
      level.stages = await _stageRepository.getRandomStagesByCount(
        level.stageCount, previouslyUsedStages);
      await _setLevelUsedStageIDs(level.stages);
    } else {
      final Tuple2<int, int> trackingIndexes = await _getStageTrackingIndexes();
      final int currentStageComplexity = trackingIndexes.item1;
      final int nextStageInComplexityIndex = trackingIndexes.item2;
      level.stages = await _stageRepository.getStageList(
        level.stageCount, currentStageComplexity, nextStageInComplexityIndex);
      await _setStageTrackingIndexes(level.stages.last);
    }

    if (level.stages.isEmpty) {
      return null;
    }

    return level;
  }

  /// Check if level is final level
  Future<bool> isFinalLevel(int levelId) async{
    final DatabaseProvider databaseProvider = DatabaseProvider();
    final int levelCount = await LevelDatabaseRepository(
      databaseProvider).getLevelCount();
    return levelCount-1 == levelId;
  }
    
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
