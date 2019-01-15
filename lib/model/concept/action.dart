import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Action extends Concept {
  static const int TYPE = 2;
  static const Color COLOR = Colors.red;

  Action({@required value, type = TYPE}) : super(value: value, type: type);
}
