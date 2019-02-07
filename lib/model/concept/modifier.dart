import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Modifier extends Concept {
  static const int ID = 21;

  Modifier({value, concepts, type = ID}) : super(value: value, concepts: concepts, type: type);
}
