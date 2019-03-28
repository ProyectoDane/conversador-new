import 'dart:math';

import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

class ConceptHelper {

  // MARK: - EASY
  static List<Concept> getEasyConcepts(final Sentence sentence)
    => getSubjectEasyConcepts(sentence) + getPredicateEasyConcepts(sentence);

  static List<Concept> getSubjectEasyConcepts(final Sentence sentence)
    => _getSubjectConcepts(sentence, Stage.DIFFICULTY_EASY);

  static List<Concept> getPredicateEasyConcepts(final Sentence sentence)
    => _getPredicateConcepts(sentence, Stage.DIFFICULTY_EASY);

  // MARK: - NORMAL
  static List<Concept> getNormalConcepts(final Sentence sentence)
    => getSubjectNormalConcepts(sentence) + getPredicateNormalConcepts(sentence);

  static List<Concept> getSubjectNormalConcepts(final Sentence sentence)
    => _getSubjectConcepts(sentence, Stage.DIFFICULTY_NORMAL);

  static List<Concept> getPredicateNormalConcepts(final Sentence sentence)
    => _getPredicateConcepts(sentence, Stage.DIFFICULTY_NORMAL);

  // MARK: - HARD
  static List<Concept> getHardConcepts(final Sentence sentence)
    => getSubjectHardConcepts(sentence) + getPredicateHardConcepts(sentence);

  static List<Concept> getSubjectHardConcepts(final Sentence sentence)
    => _getSubjectConcepts(sentence, Stage.DIFFICULTY_HARD);

  static List<Concept> getPredicateHardConcepts(final Sentence sentence)
    => _getPredicateConcepts(sentence, Stage.DIFFICULTY_HARD);

  // MARK: - MAX
  static List<Concept> getMaxConcepts(final Sentence sentence)
    => getSubjectMaxConcepts(sentence) + getPredicateMaxConcepts(sentence);

  static List<Concept> getSubjectMaxConcepts(final Sentence sentence)
    => _getSubjectConcepts(sentence, Stage.DIFFICULTY_MAX);

  static List<Concept> getPredicateMaxConcepts(final Sentence sentence)
    => _getPredicateConcepts(sentence, Stage.DIFFICULTY_MAX);


  // MARK: - Helpers
  static List<Concept> _getSubjectConcepts(Sentence sentence, int difficulty) {
    return _getConceptInDepth(sentence.subject, difficulty - 1);
  }

  static List<Concept> _getPredicateConcepts(Sentence sentence, int difficulty) {
    int depth = max(difficulty - sentence.subject.depth, 1) - 1;
    return _getConceptInDepth(sentence.predicate, depth);
  }

  static List<Concept> _getConceptInDepth(Concept concept, int depth) {
    if (concept.depth == 0 || depth == 0) return [concept];
    return concept.children.expand((concept) => _getConceptInDepth(concept, depth - 1)).toList();
  }
}
