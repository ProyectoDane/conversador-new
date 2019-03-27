import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Entity extends Concept {

  Entity({@required String value})
      : super.terminal(value: value, type: TYPE);

  static const int TYPE = 20;

}
