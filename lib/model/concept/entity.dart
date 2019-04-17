import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents an entity.
class Entity extends Concept {
  /// Creates an Entity with a value.
  Entity({@required String value}) : super.terminal(value: value, type: TYPE);

  /// Creates an entity to be stored or retrieved from the database
  Entity.data({int id, String value, this.subjectId})
      : super.terminal(value: value, type: TYPE, id: id);

  /// The subject this entity belongs to
  int subjectId;

  /// Concept type id for Entities.
  static const int TYPE = 20;
}
