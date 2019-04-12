import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/shape_painter.dart';

/// Circle shaped custom painter
class RectanglePainter extends ShapePainter {
  /// Constructor
  RectanglePainter(Color color) : super(ID, color);

  /// Id of Rectagle type
  static const int ID = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
    ..color = color;
    
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const Radius radius = Radius.circular(5);
    // The following line creates a Rounded Rectangle
    final RRect rrect = RRect.fromRectAndCorners(rect, 
    topLeft: radius, 
    topRight: radius, 
    bottomLeft: radius, 
    bottomRight: radius);

    canvas.drawRRect(rrect, paint);
  }
}