import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/model/sentence.dart';

// TODO improve this
class LevelFactory {
  static Level getLevel() {
    return _getLevel();
  }

  static Level _getLevel() {
    return Level(
      value: 1,
      maxDifficulty: Sentence.DIFFICULTY_NORMAL,
      background: 'assets/images/game/background.jpg',
      sentences: _getSentences(),
    );
  }

  static List<Sentence> _getSentences() {
    final List<Sentence> sentences = [];
    for (int i = 0; i < 2; i++) {
      sentences.add(_getSentence(i));
    }
    return sentences;
  }

  static Sentence _getSentence(int diff) {
    if (diff == 0) {
      return Sentence(difficulty: Sentence.DIFFICULTY_EASY, concepts: _getConcepts(diff));
    }

    // Diff 2
    return Sentence(difficulty: Sentence.DIFFICULTY_NORMAL, concepts: _getConcepts(diff));
  }

  static List<Concept> _getConcepts(int diff) {
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
}
