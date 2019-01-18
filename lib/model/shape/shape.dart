import 'package:flutter/material.dart';

class Shape {
  final Decoration decoration;

  Shape({this.decoration});

  Widget buildWidget({@required int pieceType, @required String content, @required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: decoration,
      child: Center(
        child: Text(
          content,
          style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 15.0),
        ),
      ),
    );
  }
}
