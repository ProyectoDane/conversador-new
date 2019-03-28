import 'dart:math';

import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

/// Helper class for getting the concepts of a sentence
/// as detailed as the difficulty requires.
class ConceptHelper {

  // MARK: - EASY
  /// Get list of concepts in the sentence for the easy difficulty
  static List<Concept> getEasyConcepts(final Sentence sentence) =>
      getSubjectEasyConcepts(sentence) + getPredicateEasyConcepts(sentence);

  /// Get list of concepts in the subject for the easy difficulty
  static List<Concept> getSubjectEasyConcepts(final Sentence sentence) =>
      _getSubjectConcepts(sentence, Stage.DIFFICULTY_EASY);

  /// Get list of concepts in the predicate for the easy difficulty
  static List<Concept> getPredicateEasyConcepts(final Sentence sentence) =>
      _getPredicateConcepts(sentence, Stage.DIFFICULTY_EASY);

  // MARK: - NORMAL
  /// Get list of concepts in the sentence for the normal difficulty
  static List<Concept> getNormalConcepts(final Sentence sentence) =>
      getSubjectNormalConcepts(sentence) + getPredicateNormalConcepts(sentence);

  /// Get list of concepts in the subject for the normal difficulty
  static List<Concept> getSubjectNormalConcepts(final Sentence sentence) =>
      _getSubjectConcepts(sentence, Stage.DIFFICULTY_NORMAL);

  /// Get list of concepts in the predicate for the normal difficulty
  static List<Concept> getPredicateNormalConcepts(final Sentence sentence) =>
      _getPredicateConcepts(sentence, Stage.DIFFICULTY_NORMAL);

  // MARK: - HARD
  /// Get list of concepts in the sentence for the hard difficulty
  static List<Concept> getHardConcepts(final Sentence sentence) =>
      getSubjectHardConcepts(sentence) + getPredicateHardConcepts(sentence);

  /// Get list of concepts in the subject for the hard difficulty
  static List<Concept> getSubjectHardConcepts(final Sentence sentence) =>
      _getSubjectConcepts(sentence, Stage.DIFFICULTY_HARD);

  /// Get list of concepts in the predicate for the hard difficulty
  static List<Concept> getPredicateHardConcepts(final Sentence sentence) =>
      _getPredicateConcepts(sentence, Stage.DIFFICULTY_HARD);

  // MARK: - MAX
  /// Get list of concepts in the sentence for the max difficulty
  static List<Concept> getMaxConcepts(final Sentence sentence) =>
      getSubjectMaxConcepts(sentence) + getPredicateMaxConcepts(sentence);

  /// Get list of concepts in the subject for the max difficulty
  static List<Concept> getSubjectMaxConcepts(final Sentence sentence) =>
      _getSubjectConcepts(sentence, Stage.DIFFICULTY_MAX);

  /// Get list of concepts in the predicate for the max difficulty
  static List<Concept> getPredicateMaxConcepts(final Sentence sentence) =>
      _getPredicateConcepts(sentence, Stage.DIFFICULTY_MAX);

  // MARK: - Helpers
  static List<Concept> _getSubjectConcepts(Sentence sentence, int difficulty) =>
    _getConceptInDepth(sentence.subject, difficulty - 1);

  static List<Concept> _getPredicateConcepts(
      Sentence sentence, int difficulty) {
    final int depth = max(difficulty - sentence.subject.depth, 1) - 1;
    return _getConceptInDepth(sentence.predicate, depth);
  }

  static List<Concept> _getConceptInDepth(Concept concept, int depth) {
    if (concept.depth == 0 || depth == 0) {
      return <Concept>[concept];
    }
    return concept.children
        .expand((Concept concept) => _getConceptInDepth(concept, depth - 1))
        .toList();
  }
}
