import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Action extends Concept {

  Action({@required String value})
      : super.terminal(value: value, type: TYPE);

  static const int TYPE = 30;
}
