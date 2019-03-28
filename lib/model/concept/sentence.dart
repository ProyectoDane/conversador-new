import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

/// Class representing a sentence with its
/// two main concepts: subject and predicate.
class Sentence {

  /// Creates a Sentence from a Subject and a Predicate
  Sentence(this.subject, this.predicate);

  /// Subject of the sentence
  final Subject subject;
  /// Predicate of the sentence
  final Predicate predicate;

  /// Get a list of concepts from the sentence
  /// going as deep as the difficulty provided.
  static List<Concept> getConceptsByDifficulty(
      final Sentence sentence,
      final int currentDifficulty
    ) => _mapDifficultyToConceptGenerators[currentDifficulty](sentence);

  /// Get a list of concepts from the subject
  /// going as deep as the difficulty provided.
  static List<Concept> getSubjectConceptsByDifficulty(
      final Sentence sentence,
      final int currentDifficulty
    ) => _mapDifficultyToSubjectConceptGenerators[currentDifficulty](sentence);

  /// Get a list of concepts from the predicate
  /// going as deep as the difficulty provided.
  static List<Concept> getPredicateConceptsByDifficulty(
      final Sentence sentence,
      final int currentDifficulty
    ) =>
      _mapDifficultyToPredicateConceptGenerators[currentDifficulty](sentence);

  static const Map<int, List<Concept> Function(Sentence)>
    _mapDifficultyToConceptGenerators =
    <int, List<Concept> Function(Sentence)>{
      Stage.DIFFICULTY_EASY: ConceptHelper.getEasyConcepts,
      Stage.DIFFICULTY_NORMAL: ConceptHelper.getNormalConcepts,
      Stage.DIFFICULTY_HARD: ConceptHelper.getHardConcepts,
      Stage.DIFFICULTY_MAX: ConceptHelper.getMaxConcepts
  };

  static const Map<int, List<Concept> Function(Sentence)>
    _mapDifficultyToSubjectConceptGenerators =
    <int, List<Concept> Function(Sentence)>{
      Stage.DIFFICULTY_EASY: ConceptHelper.getSubjectEasyConcepts,
      Stage.DIFFICULTY_NORMAL: ConceptHelper.getSubjectNormalConcepts,
      Stage.DIFFICULTY_HARD: ConceptHelper.getSubjectHardConcepts,
      Stage.DIFFICULTY_MAX: ConceptHelper.getSubjectMaxConcepts
  };

  static const Map<int, List<Concept> Function(Sentence)>
    _mapDifficultyToPredicateConceptGenerators =
    <int, List<Concept> Function(Sentence)>{
      Stage.DIFFICULTY_EASY: ConceptHelper.getPredicateEasyConcepts,
      Stage.DIFFICULTY_NORMAL: ConceptHelper.getPredicateNormalConcepts,
      Stage.DIFFICULTY_HARD: ConceptHelper.getPredicateHardConcepts,
      Stage.DIFFICULTY_MAX: ConceptHelper.getPredicateMaxConcepts
  };

}
