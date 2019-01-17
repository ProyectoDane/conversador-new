import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Modifier extends Concept {
  static const int ID = 3;

  Modifier({@required value, id = ID}) : super(value: value, id: id);
}
