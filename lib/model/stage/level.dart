import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Level {
  static const int DIFFICULTY_EASY = 1;
  static const int DIFFICULTY_NORMAL = 2;
  static const int DIFFICULTY_HARD = 3;

  final int difficulty;
  final List<Concept> concepts;

  Level({@required this.difficulty, @required this.concepts});
}
