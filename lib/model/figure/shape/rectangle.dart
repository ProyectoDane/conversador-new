import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';

class Rectangle extends Shape {

  Rectangle({@required Color color, Color borderColor}) : super(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderColor: borderColor,
      shape: BoxShape.rectangle,
      id: ID);

  static const int ID = 1;

}
