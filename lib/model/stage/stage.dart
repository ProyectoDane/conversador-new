import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:meta/meta.dart';

class Stage {
  static const int DIFFICULTY_EASY = 1;
  static const int DIFFICULTY_NORMAL = 2;
  static const int DIFFICULTY_HARD = 3;
  static const int DIFFICULTY_MAX = 4;

  final int value;
  final int maxDifficulty;
  final String backgroundUri;
  final Sentence sentence;

  Stage({@required this.value, @required this.maxDifficulty, @required this.backgroundUri, @required this.sentence});

  static int increaseDifficulty(final currentDifficulty) => currentDifficulty + 1;

  static List<Concept> getConceptsByDifficulty(final sentence, final currentDifficulty) =>
      Sentence.getConceptsByDifficulty(sentence, currentDifficulty);
}
