import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Subject extends Concept {

  Subject({@required String value})
      : super.terminal(value: value, type: TYPE);

  Subject.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);

  static const int TYPE = 10;

}
