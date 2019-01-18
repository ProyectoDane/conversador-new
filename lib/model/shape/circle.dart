import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class Circle extends Shape {
  static const int ID = 2;

  Circle({@required color}) : super(color: color);

  @override
  Decoration getDecoration(int type) => BoxDecoration(
        color: Shape.getColorByType(color, type),
        shape: BoxShape.circle,
      );
}
