import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

abstract class Shape {
  static const double BASE_FONT_SIZE = 15.0;
  static const double BASE_SIZE = 80.0;
  static const double BASE_RADIUS = 5.0;
  static const Color BASE_COLOR = Colors.black26;

  final Color color;

  Shape({@required this.color});

  static Color getColorByType(Color color, int type) => {
    Piece.TARGET_INITIAL: BASE_COLOR,
    Piece.TARGET_COMPLETED: color,
    Piece.DRAG_INITIAL: color,
    Piece.DRAG_FEEDBACK: color.withOpacity(0.5),
    Piece.DRAG_COMPLETED: color.withOpacity(0.5),
  }[type];

  Widget create({@required String content, @required double size, int type}) {
    return Container(
      width: size,
      height: size,
      decoration: getDecoration(type),
      child: Center(
        child: Text(
          content,
          style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: BASE_FONT_SIZE),
        ),
      ),
    );
  }

  Decoration getDecoration(int type);
}
