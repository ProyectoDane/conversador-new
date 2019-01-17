import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Subject extends Concept {
  static const int ID = 1;

  Subject({@required value, id = ID}) : super(value: value, id: id);
}
