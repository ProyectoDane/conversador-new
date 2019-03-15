import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:meta/meta.dart';

class LiveStage {
  final List<Concept> concepts;
  final int difficulty;

  LiveStage(
      {@required Sentence sentence,
      @required this.difficulty})
  : this.concepts = Sentence.getConceptsByDifficulty(sentence, difficulty);
}
