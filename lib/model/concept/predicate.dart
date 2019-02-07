import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Predicate extends Concept {
  static const int ID = 11;

  Predicate({value, concepts, type = ID}) : super(value: value, concepts: concepts, type: type);
}
