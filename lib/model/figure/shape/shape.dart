import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';

/// Class representing the shape of a piece.
abstract class Shape extends BoxDecoration {

  /// Creates a Shape based on:
  /// - the box shape, optionally
  /// - the border radius, optionally
  /// - the border color, optionally
  /// - the shape's id
  /// - and finally, the color with which to fill the shape
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
        width: 1,
      ) : null,
  );

  /// Shape's id.
  final int id;

  /// Returns a Shape from it's id and the color with which to fill it,
  /// or null if the idis invalid.
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