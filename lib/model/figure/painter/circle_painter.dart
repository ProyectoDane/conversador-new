import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/shape_painter.dart';

/// Circle shaped custom painter
class CirclePainter extends ShapePainter {
  /// Constructor
  CirclePainter(Color color) : super(ID, color);

  /// Id of Circle type
  static const int ID = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
    ..color = color;
    
    final Offset offset = Offset(size.width/2, size.height/2);
    canvas.drawCircle(offset, size.width/2, paint);
  }
}