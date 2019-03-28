import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents a complement of an action.
class Complement extends Concept {

  /// Creates an Complement with a value
  Complement({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Creates an Complement with the children concepts
  Complement.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);

  /// Concept type id for Complements.
  static const int TYPE = 31;

}
