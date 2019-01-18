import 'package:flutter/material.dart';

abstract class Concept {
  final String value;
  final int type;

  Concept({@required this.value, @required this.type});
}
