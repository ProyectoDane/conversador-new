import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents a link between concepts.
class Linker extends Concept {

  /// Creates a Link with a value.
  Linker({@required String value})
      : super.terminal(value: value, type: TYPE);

  /// Concept type id for Linkers.
  static const int TYPE = 22;

}
