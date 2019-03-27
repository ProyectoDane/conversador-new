import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Modifier extends Concept {

  Modifier({@required String value})
      : super.terminal(value: value, type: TYPE);

  static const int TYPE = 21;

}
