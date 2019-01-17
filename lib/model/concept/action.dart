import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Action extends Concept {
  static const int ID = 2;

  Action({@required value, id = ID}) : super(value: value, id: id);
}
