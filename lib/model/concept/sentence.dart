import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

class Sentence {
  final Subject subject;
  final Predicate predicate;

  Sentence(this.subject, this.predicate);

  static List<Concept> getConceptsByDifficulty(sentence, currentDifficulty) =>
      _mapDifficultyToConceptGenerators[currentDifficulty](sentence);

  static const Map<int, Function> _mapDifficultyToConceptGenerators = {
    Stage.DIFFICULTY_EASY: _getEasyConcepts,
    Stage.DIFFICULTY_NORMAL: _getNormalConcepts,
    Stage.DIFFICULTY_HARD: _getHardConcepts,
    Stage.DIFFICULTY_MAX: _getMaxConcepts
  };

  static List<Concept> _getEasyConcepts(sentence) => ConceptHelper.getEasyConcepts(sentence);

  static List<Concept> _getNormalConcepts(sentence) => ConceptHelper.getNormalConcepts(sentence);

  static List<Concept> _getHardConcepts(sentence) => ConceptHelper.getHardConcepts(sentence);

  static List<Concept> _getMaxConcepts(sentence) => ConceptHelper.getMaxConcepts(sentence);
}
