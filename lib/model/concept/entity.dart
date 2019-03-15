import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Entity extends Concept {
  static const int TYPE = 20;

  Entity({@required String value, List<Concept> children = const <Concept>[], int type = TYPE})
      : super(value: value, children: children, type: type);
}
