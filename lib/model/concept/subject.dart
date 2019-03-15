import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Subject extends Concept {
  static const int TYPE = 10;

  Subject({String value = '', List<Concept> children = const <Concept>[], int type = TYPE})
      : super(value: value, children: children, type: type);
}
