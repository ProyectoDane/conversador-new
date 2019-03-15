import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Predicate extends Concept {
  static const int TYPE = 11;

  Predicate({String value = '', List<Concept> children = const <Concept>[], int type = TYPE})
      : super(value: value, children: children, type: type);
}
