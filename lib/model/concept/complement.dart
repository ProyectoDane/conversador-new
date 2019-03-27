import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Complement extends Concept {

  Complement({@required String value})
      : super.terminal(value: value, type: TYPE);

  Complement.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);

  static const int TYPE = 31;

}
