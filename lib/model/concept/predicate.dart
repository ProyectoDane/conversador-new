import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents the predicate of a sentence.
class Predicate extends Concept {
  /// Creates an Predicate with a value
  Predicate({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Creates a Predicate with its children concepts.
  Predicate.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);

  /// Creates a predicate to be stored or retrieved from the database
  Predicate.data({int id, String value, this.sentenceId})
      : super.terminal(value: value, type: TYPE, id: id);

  /// The sentence this subject belongs to
  int sentenceId;

  /// Concept type id for Predicates.
  static const int TYPE = 11;
}
