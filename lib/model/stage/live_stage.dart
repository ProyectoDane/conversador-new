import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:meta/meta.dart';

/// Represents a stage at a given level.
/// It has certain subject and predicate concepts
/// and it represents a certain difficulty.
class LiveStage {

  /// Creates a LiveStage based on the sentence
  /// and the difficulty level specified
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

  /// Subject concepts to be used in this LiveStage
  final List<Concept> subjectConcepts;
  /// Predicate concepts to be used in this LiveStage
  final List<Concept> predicateConcepts;
  /// Difficulty of this LiveStage
  final int difficulty;

}
