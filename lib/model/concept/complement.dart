import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents a complement of an action.
class Complement extends Concept {
  /// Creates an Complement with a value
  Complement({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Creates a Complement with the children concepts
  Complement.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);

  /// Creates a Complement to be stored or retrieved from the database
  Complement.data({int id, String value, this.predicateId})
      : super.terminal(value: value, type: TYPE, id: id);

  /// The predicate this complement belongs to
  int predicateId;

  /// Concept type id for Complements.
  static const int TYPE = 31;
}
