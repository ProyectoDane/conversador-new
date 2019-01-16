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

  Color getColor(int type) => {
        Piece.TARGET_INITIAL: Shape.BASE_COLOR,
        Piece.TARGET_COMPLETED: color,
        Piece.DRAG_INITIAL: color,
        Piece.DRAG_FEEDBACK: color.withOpacity(0.5),
        Piece.DRAG_COMPLETED: color.withOpacity(0.5),
      }[type];
}
