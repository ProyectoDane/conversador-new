import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';

/// Class representing a sentence with its
/// two main concepts: subject and predicate.
class Sentence {

  /// Creates a Sentence from a Subject and a Predicate
  Sentence(this.subject, this.predicate);

  /// Subject of the sentence
  final Subject subject;
  /// Predicate of the sentence
  final Predicate predicate;

  /// Get the whole concept list of a sentence,
  /// according to the depth required
  static List<Concept> getConceptsBySentenceDepth(
          final Sentence sentence, final int depth) =>
      ConceptHelper.getConcepts(sentence, depth);

  /// Get the subject concept list of a sentence,
  /// according to the depth required
  static List<Concept> getSubjectConceptsBySentenceDepth(
          final Sentence sentence, final int depth) =>
      ConceptHelper.getSubjectConcepts(sentence, depth);

  /// Get the predicate concept list of a sentence,
  /// according to the depth required
  static List<Concept> getPredicateConceptsBySentenceDepth(
          final Sentence sentence, final int depth) =>
      ConceptHelper.getPredicateConcepts(sentence, depth);
}
