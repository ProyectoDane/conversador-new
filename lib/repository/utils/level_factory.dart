import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/model/sentence.dart';

// TODO improve this
class LevelFactory {
  static Level getLevel(int level) => level == 0 ? _getFootballLevel() : _getFoodLevel();

  static Level _getFootballLevel() => Level(
        value: 1,
        maxDifficulty: Sentence.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/football.jpg',
        sentences: _getFootballSentences(),
      );

  static List<Sentence> _getFootballSentences() {
    final List<Sentence> sentences = [];
    for (int i = 0; i < 2; i++) {
      sentences.add(_getFootballSentence(i));
    }
    return sentences;
  }

  static Sentence _getFootballSentence(int diff) {
    if (diff == 0) {
      return Sentence(difficulty: Sentence.DIFFICULTY_EASY, concepts: _getFootballConcepts(diff));
    }

    // Diff 2
    return Sentence(difficulty: Sentence.DIFFICULTY_NORMAL, concepts: _getFootballConcepts(diff));
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

  static Level _getFoodLevel() => Level(
        value: 1,
        maxDifficulty: Sentence.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/food.jpg',
        sentences: _getFoodSentences(),
      );

  static List<Sentence> _getFoodSentences() {
    final List<Sentence> sentences = [];
    for (int i = 0; i < 2; i++) {
      sentences.add(_getFoodSentence(i));
    }
    return sentences;
  }

  static Sentence _getFoodSentence(int diff) {
    if (diff == 0) {
      return Sentence(difficulty: Sentence.DIFFICULTY_EASY, concepts: _getFoodConcepts(diff));
    }

    // Diff 2
    return Sentence(difficulty: Sentence.DIFFICULTY_NORMAL, concepts: _getFoodConcepts(diff));
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
