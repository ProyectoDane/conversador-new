import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';

class Rectangle extends Shape {
  static const int ID = 1;

  Rectangle({@required Color color, Color borderColor}) : super(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderColor: borderColor,
      shape: BoxShape.rectangle,
      id: ID);
}
