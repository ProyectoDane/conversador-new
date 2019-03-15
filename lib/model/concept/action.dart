import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Action extends Concept {
  static const int TYPE = 30;

  Action({@required String value, List<Concept> children = const <Concept>[], int type = TYPE})
      : super(value: value, children: children, type: type);
}
