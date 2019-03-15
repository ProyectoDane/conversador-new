import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:meta/meta.dart';

class LiveStage {
  final List<Concept> subjectConcepts;
  final List<Concept> predicateConcepts;
  final int difficulty;

  LiveStage(
      {@required Sentence sentence,
      @required this.difficulty}):
        this.subjectConcepts = Sentence.getSubjectConceptsByDifficulty(sentence, difficulty),
        this.predicateConcepts = Sentence.getPredicateConceptsByDifficulty(sentence, difficulty);
}
