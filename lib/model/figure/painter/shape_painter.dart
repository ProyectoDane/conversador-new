import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/circle_painter.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/rectangle_painter.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/diamond_painter.dart';

/// Painter parent class for custom shapes.
class ShapePainter extends CustomPainter {
  /// Constructor
  ShapePainter(this.id, this.color);

  /// This is shared by the class children
  final Color color;
  /// Shape's id.
  final int id;

  @override
  void paint(Canvas canvas, Size size) {
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  /// Returns a CustomPainter from it's id and the color with which to fill it,
  /// or null if the id is invalid.
  static ShapePainter fromID(int id, Color color) {
    if (id == CirclePainter.ID) {
      return CirclePainter(color);
    }
    if (id == RectanglePainter.ID) {
      return RectanglePainter(color);
    }
    if (id == DiamondPainter.ID) {
      return DiamondPainter(color);
    }

    return null;
  }
}