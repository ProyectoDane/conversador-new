import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';

abstract class Shape extends BoxDecoration {
  final int id;
  Shape({
    @required this.id,
    Color color,
    BorderRadius borderRadius,
    Color borderColor,
    BoxShape shape}): super(
      color: color,
      shape: shape,
      borderRadius: borderRadius,
      border: (borderColor != null) ? Border.all(
        color: borderColor,
        width: 1.0,
      ) : null,
  );

  static Shape fromID(int id, Color color) {
    if (id == Circle.ID) {
      return Circle(color);
    }
    if (id == Rectangle.ID) {
      return Rectangle(color: color);
    }
    return null;
  }
}