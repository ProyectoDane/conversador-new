import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents a modifier of an entity or complement.
class Modifier extends Concept {
  /// Creates a Modifier with a value
  Modifier({@required String value}) : super.terminal(value: value, type: TYPE);

  /// Creates a Modifier to be stored or retrieved from the database
  Modifier.data({int id, String value, this.subjectId})
      : super.terminal(value: value, type: TYPE, id: id);

  /// The subject this modifier belongs to
  int subjectId;

  /// Concept type id for Modifiers.
  static const int TYPE = 21;
}
