import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Entity extends Concept {
  static const int TYPE = 20;

  Entity({@required String value})
      : super.terminal(value: value, type: TYPE);
}
