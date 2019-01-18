import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class Rectangle extends Shape {
  static const int ID = 1;

  Rectangle({@required color}) : super(color: color);

  @override
  Decoration getDecoration(int type) => BoxDecoration(
        color: Shape.getColorByType(color, type),
        borderRadius: BorderRadius.all(Radius.circular(Shape.BASE_RADIUS)),
      );
}
