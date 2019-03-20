import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';

class Circle extends Shape {
  static const int ID = 2;

  Circle(Color color) : super(color: color, shape: BoxShape.circle, id: ID);
}
