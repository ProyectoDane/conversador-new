import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents an action (a verb)
class Action extends Concept {

  /// Creates an Action with a certain value
  Action({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Concept type id for Actions.
  static const int TYPE = 30;

}
