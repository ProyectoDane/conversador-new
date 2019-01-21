import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/thing.dart';
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
    for (int i = 0; i < 3; i++) {
      levels.add(_getFootballLevel(i));
    }
    return levels;
  }

  static Level _getFootballLevel(int diff) {
    switch (diff) {
      case 0:
        return Level(difficulty: Level.DIFFICULTY_EASY, concepts: _getFootballConcepts(diff));
      case 1:
        return Level(difficulty: Level.DIFFICULTY_NORMAL, concepts: _getFootballConcepts(diff));
      case 2:
      default:
        return Level(difficulty: Level.DIFFICULTY_HARD, concepts: _getFootballConcepts(diff));
    }
  }

  static List<Concept> _getFootballConcepts(int diff) {
    List<Concept> concepts = [];
    switch (diff) {
      case 0:
        concepts.add(Subject(value: 'el niño'));
        concepts.add(Action(value: 'juega con la pelota'));
        return concepts;
      case 1:
        concepts.add(Modifier(value: 'el'));
        concepts.add(Subject(value: 'niño'));
        concepts.add(Action(value: 'juega con la pelota'));
        return concepts;
      case 2:
      default:
        concepts.add(Modifier(value: 'el'));
        concepts.add(Subject(value: 'niño'));
        concepts.add(Action(value: 'juega'));
        concepts.add(Thing(value: 'con la pelota'));
        return concepts;
    }
  }

  static Stage _getFoodStage() => Stage(
        value: 1,
        maxDifficulty: Level.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/food.jpg',
        levels: _getFoodLevels(),
      );

  static List<Level> _getFoodLevels() {
    final List<Level> levels = [];
    for (int i = 0; i < 3; i++) {
      levels.add(_getFoodLevel(i));
    }
    return levels;
  }

  static Level _getFoodLevel(int diff) {
    switch (diff) {
      case 0:
        return Level(difficulty: Level.DIFFICULTY_EASY, concepts: _getFoodConcepts(diff));
      case 1:
        return Level(difficulty: Level.DIFFICULTY_NORMAL, concepts: _getFoodConcepts(diff));
      case 2:
      default:
        return Level(difficulty: Level.DIFFICULTY_HARD, concepts: _getFoodConcepts(diff));
    }
  }

  static List<Concept> _getFoodConcepts(int diff) {
    List<Concept> concepts = [];
    switch (diff) {
      case 0:
        concepts.add(Subject(value: 'la niña'));
        concepts.add(Action(value: 'come la comida'));
        return concepts;
      case 1:
        concepts.add(Modifier(value: 'la'));
        concepts.add(Subject(value: 'niña'));
        concepts.add(Action(value: 'come la comida'));
        return concepts;
      case 2:
      default:
        concepts.add(Modifier(value: 'la'));
        concepts.add(Subject(value: 'niña'));
        concepts.add(Action(value: 'come'));
        concepts.add(Thing(value: 'la comida'));
        return concepts;
    }
  }
}
