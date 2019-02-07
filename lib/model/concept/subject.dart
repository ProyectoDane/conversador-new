import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Subject extends Concept {
  static const int ID = 10;

  Subject({value, concepts, type = ID}) : super(value: value, concepts: concepts, type: type);
}
