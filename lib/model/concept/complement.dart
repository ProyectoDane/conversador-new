import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Complement extends Concept {
  static const int TYPE = 31;

  Complement({value = '', children = const <Concept>[], type = TYPE})
      : super(value: value, children: children, type: type);
}
