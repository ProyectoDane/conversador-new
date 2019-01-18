import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class Thing extends Concept {
  static const int ID = 4;

  Thing({@required value, type = ID}) : super(value: value, type: type);
}
