import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';

/// Rectangle shape
class Rectangle extends Shape {

  /// Creates a Rectangle filled with the given color,
  /// and optionally a border color.
  Rectangle({@required Color color, Color borderColor}) : super(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderColor: borderColor,
      shape: BoxShape.rectangle,
      id: ID);

  /// Id of Rectangle type
  static const int ID = 1;

}
