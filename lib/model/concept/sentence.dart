import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

class Sentence {
  final Subject subject;
  final Predicate predicate;

  Sentence(this.subject, this.predicate);

  static List<Concept> getConceptsByDifficulty(final Sentence sentence, final int currentDifficulty) =>
      _mapDifficultyToConceptGenerators[currentDifficulty](sentence);

  static List<Concept> getSubjectConceptsByDifficulty(final Sentence sentence, final int currentDifficulty) =>
      _mapDifficultyToSubjectConceptGenerators[currentDifficulty](sentence);/////

  static List<Concept> getPredicateConceptsByDifficulty(final Sentence sentence, final int currentDifficulty) =>
      _mapDifficultyToPredicateConceptGenerators[currentDifficulty](sentence);/////

  static const Map<int, List<Concept> Function(Sentence)> _mapDifficultyToConceptGenerators = {
    Stage.DIFFICULTY_EASY: ConceptHelper.getEasyConcepts,
    Stage.DIFFICULTY_NORMAL: ConceptHelper.getNormalConcepts,
    Stage.DIFFICULTY_HARD: ConceptHelper.getHardConcepts,
    Stage.DIFFICULTY_MAX: ConceptHelper.getMaxConcepts
  };

  static const Map<int, List<Concept> Function(Sentence)> _mapDifficultyToSubjectConceptGenerators = {
    Stage.DIFFICULTY_EASY: ConceptHelper.getSubjectEasyConcepts,
    Stage.DIFFICULTY_NORMAL: ConceptHelper.getSubjectNormalConcepts,
    Stage.DIFFICULTY_HARD: ConceptHelper.getSubjectHardConcepts,
    Stage.DIFFICULTY_MAX: ConceptHelper.getSubjectMaxConcepts
  };

  static const Map<int, List<Concept> Function(Sentence)> _mapDifficultyToPredicateConceptGenerators = {
    Stage.DIFFICULTY_EASY: ConceptHelper.getPredicateEasyConcepts,
    Stage.DIFFICULTY_NORMAL: ConceptHelper.getPredicateNormalConcepts,
    Stage.DIFFICULTY_HARD: ConceptHelper.getPredicateHardConcepts,
    Stage.DIFFICULTY_MAX: ConceptHelper.getPredicateMaxConcepts
  };

}
