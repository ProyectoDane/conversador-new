import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';

/// Circle shape
class Circle extends Shape {

  /// Creates a Circle filled with color.
  Circle(Color color) : super(color: color, shape: BoxShape.circle, id: ID);

  /// Id of Circle type
  static const int ID = 2;

}
