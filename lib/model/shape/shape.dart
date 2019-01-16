import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

abstract class Shape {
  static const double BASE_FONT_SIZE = 15.0;
  static const double BASE_SIZE = 80.0;
  static const double BASE_RADIUS = 5.0;
  static const Color BASE_COLOR = Colors.black26;

  final Color color;

  Shape({@required this.color});

  Widget build({@required String content, @required double size, int type, bool showText});

  Color getColor(int type) {
    switch (type) {
      case Piece.TARGET_INITIAL:
        return Shape.BASE_COLOR;
      case Piece.TARGET_COMPLETED:
      case Piece.DRAG_INITIAL:
        return color;
      case Piece.DRAG_FEEDBACK:
      case Piece.DRAG_COMPLETED:
      default:
        return color.withOpacity(0.5);
    }
  }
}
