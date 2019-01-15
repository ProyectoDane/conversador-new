import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class Circle extends Shape {
  static const int TYPE = 2;

  Circle({@required color}) : super(color: color);

  @override
  Widget build({@required String concept, @required double size, int type, bool showText}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: getColor(type), shape: BoxShape.circle),
      child: showText
          ? Center(
              child: Text(
                concept,
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: Shape.BASE_FONT_SIZE),
              ),
            )
          : Container(),
    );
  }
}
