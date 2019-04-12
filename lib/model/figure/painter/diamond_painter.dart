import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/shape_painter.dart';

/// Diamond shaped custom painter
class DiamondPainter extends ShapePainter {
  /// Constructor
  DiamondPainter(Color color) : super(ID, color);

  /// Id of Diamond type
  static const int ID = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
    ..color = color;
    
    final Path path = Path()
    ..moveTo(size.width / 2, 0)
    ..lineTo(size.width, size.height / 2)
    ..lineTo(size.width / 2, size.height)
    ..lineTo(0, size.height / 2)
    ..close();
    canvas.drawPath(path, paint);
  }
}