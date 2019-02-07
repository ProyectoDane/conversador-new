import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Complement extends Concept {
  static const int ID = 31;

  Complement({value, concepts, type = ID}) : super(value: value, concepts: concepts, type: type);
}
