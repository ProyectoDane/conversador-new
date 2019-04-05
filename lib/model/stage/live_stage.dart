import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:meta/meta.dart';

/// Represents a stage at a given level.
/// It has certain subject and predicate concepts
/// and it represents a certain difficulty.
class LiveStage {
  /// Creates a LiveStage based on the sentence
  /// and the depth specified
  LiveStage({@required Sentence sentence, @required this.depth})
      : subjectConcepts =
            Sentence.getSubjectConceptsBySentenceDepth(sentence, depth),
        predicateConcepts =
            Sentence.getPredicateConceptsBySentenceDepth(sentence, depth);

  /// Subject concepts to be used in this LiveStage
  final List<Concept> subjectConcepts;

  /// Predicate concepts to be used in this LiveStage
  final List<Concept> predicateConcepts;

  /// Depth of the sentence this LiveStage represents
  final int depth;
}
