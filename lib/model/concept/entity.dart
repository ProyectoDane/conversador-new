import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents an entity.
class Entity extends Concept {

  /// Creates an Entity with a value.
  Entity({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Concept type id for Entities.
  static const int TYPE = 20;

}
