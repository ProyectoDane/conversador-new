import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Action extends Concept {
  static const int TYPE = 30;

  Action({@required value, children = const <Concept>[], type = TYPE})
      : super(value: value, children: children, type: type);
}
