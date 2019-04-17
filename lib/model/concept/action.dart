import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents an action (a verb)
class Action extends Concept {
  /// Creates an Action with a certain value
  Action({@required String value}) : super.terminal(value: value, type: TYPE);

  /// Creates an Action to be stored or retrieved from the database
  Action.data({int id, String value, this.predicateId})
      : super.terminal(value: value, type: TYPE, id: id);

  /// The predicate this action belongs to
  int predicateId;

  /// Concept type id for Actions.
  static const int TYPE = 30;
}
