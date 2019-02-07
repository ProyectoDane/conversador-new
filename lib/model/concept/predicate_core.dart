import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

// TODO delete cores
class PredicateCore extends Concept {
  static const int ID = 30;

  PredicateCore({@required value, concepts, type = ID}) : super(value: value, concepts: concepts, type: type);
}
