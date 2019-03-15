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

  static const Map<int, List<Concept> Function(Sentence)> _mapDifficultyToConceptGenerators = {
    Stage.DIFFICULTY_EASY: _getEasyConcepts,
    Stage.DIFFICULTY_NORMAL: _getNormalConcepts,
    Stage.DIFFICULTY_HARD: _getHardConcepts,
    Stage.DIFFICULTY_MAX: _getMaxConcepts
  };

  static List<Concept> _getEasyConcepts(final Sentence sentence) => ConceptHelper.getEasyConcepts(sentence);

  static List<Concept> _getNormalConcepts(final Sentence sentence) => ConceptHelper.getNormalConcepts(sentence);

  static List<Concept> _getHardConcepts(final Sentence sentence) => ConceptHelper.getHardConcepts(sentence);

  static List<Concept> _getMaxConcepts(final Sentence sentence) => ConceptHelper.getMaxConcepts(sentence);
}
