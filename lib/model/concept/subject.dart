import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Subject extends Concept {
  static const int TYPE = 1;
  static const Color COLOR = Colors.green;

  Subject({@required value, type = TYPE}) : super(value: value, type: type);
}
