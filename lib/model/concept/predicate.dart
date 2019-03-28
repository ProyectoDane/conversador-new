import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Predicate extends Concept {
  static const int TYPE = 11;

  Predicate({@required String value})
      : super.terminal(value: value, type: TYPE);

  Predicate.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);
}
