import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class Triangle extends Shape {
  static const int TYPE = 3;

  Triangle({@required id, @required color}) : super(id: id, color: color);

  @override
  Widget build({@required String value, @required double size, int type, bool showText}) {
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
                value,
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: Shape.BASE_FONT_SIZE),
              ),
            )
          : Container(),
    );
  }
}
