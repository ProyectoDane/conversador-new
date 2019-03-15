import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Complement extends Concept {
  static const int TYPE = 31;

  Complement({String value = '', List<Concept> children = const <Concept>[], int type = TYPE})
      : super(value: value, children: children, type: type);
}
