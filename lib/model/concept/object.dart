import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents an object in a sentence.
class Object extends Concept {

  /// Creates an Object with a value.
  Object({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Concept type id for Objects.
  static const int TYPE = 23;

}
