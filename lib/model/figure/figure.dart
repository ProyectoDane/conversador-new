import 'package:flutter/material.dart';

class Figure {
  final Decoration decoration;

  Figure({this.decoration});

  Widget buildWidget({@required int pieceType, @required String content, @required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: decoration,
      child: Center(
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 13.0),
        ),
      ),
    );
  }
}
