import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class Rectangle extends Shape {
  static const int TYPE = 1;

  Rectangle({@required color}) : super(color: color);

  @override
  Widget build({@required String content, @required double size, int type, bool showText}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: getColor(type),
          borderRadius: BorderRadius.all(
            Radius.circular(Shape.BASE_RADIUS),
          )),
      child: showText
          ? Center(
              child: Text(
                content,
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: Shape.BASE_FONT_SIZE),
              ),
            )
          : Container(),
    );
  }
}
