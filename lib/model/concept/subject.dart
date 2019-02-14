import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Subject extends Concept {
  static const int TYPE = 10;

  Subject({value = '', children = const <Concept>[], type = TYPE})
      : super(value: value, children: children, type: type);
}
