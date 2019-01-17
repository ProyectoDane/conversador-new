import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

// TODO improve this
class StageFactory {
  static Stage getStage(int stage) => stage == 0 ? _getFootballStage() : _getFoodStage();

  static Stage _getFootballStage() => Stage(
        value: 1,
        maxDifficulty: Level.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/football.jpg',
        levels: _getFootballLevels(),
      );

  static List<Level> _getFootballLevels() {
    final List<Level> levels = [];
    for (int i = 0; i < 2; i++) {
      levels.add(_getFootballLevel(i));
    }
    return levels;
  }

  static Level _getFootballLevel(int diff) {
    if (diff == 0) {
      return Level(difficulty: Level.DIFFICULTY_EASY, concepts: _getFootballConcepts(diff));
    }

    // Diff 2
    return Level(difficulty: Level.DIFFICULTY_NORMAL, concepts: _getFootballConcepts(diff));
  }

  static List<Concept> _getFootballConcepts(int diff) {
    List<Concept> concepts = [];
    if (diff == 0) {
      concepts.add(Subject(value: 'el niño'));
      concepts.add(Action(value: 'juega'));
    } else {
      // Diff 2
      concepts.add(Modifier(value: 'el'));
      concepts.add(Subject(value: 'niño'));
      concepts.add(Action(value: 'juega'));
    }
    return concepts;
  }

  static Stage _getFoodStage() => Stage(
        value: 1,
        maxDifficulty: Level.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/food.jpg',
        levels: _getFoodLevels(),
      );

  static List<Level> _getFoodLevels() {
    final List<Level> levels = [];
    for (int i = 0; i < 2; i++) {
      levels.add(_getFoodLevel(i));
    }
    return levels;
  }

  static Level _getFoodLevel(int diff) {
    if (diff == 0) {
      return Level(difficulty: Level.DIFFICULTY_EASY, concepts: _getFoodConcepts(diff));
    }

    // Diff 2
    return Level(difficulty: Level.DIFFICULTY_NORMAL, concepts: _getFoodConcepts(diff));
  }

  static List<Concept> _getFoodConcepts(int diff) {
    List<Concept> concepts = [];
    if (diff == 0) {
      concepts.add(Subject(value: 'la niña'));
      concepts.add(Action(value: 'come'));
    } else {
      // Diff 2
      concepts.add(Modifier(value: 'la'));
      concepts.add(Subject(value: 'niña'));
      concepts.add(Action(value: 'come'));
    }
    return concepts;
  }
}
