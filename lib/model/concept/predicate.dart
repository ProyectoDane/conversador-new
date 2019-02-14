import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Predicate extends Concept {
  static const int TYPE = 11;

  Predicate({value = '', children = const <Concept>[], type = TYPE})
      : super(value: value, children: children, type: type);
}
