import 'package:flutter/material.dart';

class Shape {
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;
  static const int TRIANGLE = 3;
  static const List<int> SHAPES = [RECTANGLE, CIRCLE, TRIANGLE];

  final int id;
  final Color color;
  final int type;

  Shape({@required this.id, @required this.color, @required this.type});
}
