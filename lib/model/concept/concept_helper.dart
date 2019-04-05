import 'dart:math';

import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';

/// Helper class for getting the concepts of a sentence
/// as detailed as the difficulty requires.
class ConceptHelper {
  // MARK: - Get depth
  /// Get maximum depth of a sentence
  static int getSentenceDepth(final Sentence sentence) =>
      sentence.subject.depth + sentence.predicate.depth;

  // MARK: - Get concepts
  /// Get the whole concept list of a sentence,
  /// according to the depth required
  static List<Concept> getConcepts(final Sentence sentence, int depth) =>
      getSubjectConcepts(sentence, depth) +
      getPredicateConcepts(sentence, depth);

  /// Get the subject concept list of a sentence,
  /// according to the depth required
  static List<Concept> getSubjectConcepts(Sentence sentence, int depth) =>
      _getConceptInDepth(sentence.subject, depth);

  /// Get the whole predicate list of a sentence,
  /// according to the depth required
  static List<Concept> getPredicateConcepts(Sentence sentence, int depth) {
    final int finalDepth = max(depth - sentence.subject.depth, 0);
    return _getConceptInDepth(sentence.predicate, finalDepth);
  }

  // MARK: - Helpers
  static List<Concept> _getConceptInDepth(Concept concept, int depth) {
    if (concept.depth == 0 || depth == 0) {
      return <Concept>[concept];
    }
    return concept.children
        .expand((Concept concept) => _getConceptInDepth(concept, depth - 1))
        .toList();
  }
}
