import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Modifier extends Concept {
  static const int TYPE = 3;
  static const Color COLOR = Colors.blue;

  Modifier({@required value, type = TYPE}) : super(value: value, type: type);
}
