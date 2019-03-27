import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:meta/meta.dart';

class LiveStage {

  LiveStage({
    @required Sentence sentence,
    @required this.difficulty
  }):
    subjectConcepts = Sentence.getSubjectConceptsByDifficulty(
        sentence,
        difficulty
    ),
    predicateConcepts = Sentence.getPredicateConceptsByDifficulty(
        sentence,
        difficulty
    );

  final List<Concept> subjectConcepts;
  final List<Concept> predicateConcepts;
  final int difficulty;

}
