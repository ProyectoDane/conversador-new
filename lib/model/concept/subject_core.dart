import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

// TODO delete cores
class SubjectCore extends Concept {
  static const int ID = 20;

  SubjectCore({@required value, concepts, type = ID}) : super(value: value, concepts: concepts, type: type);
}
