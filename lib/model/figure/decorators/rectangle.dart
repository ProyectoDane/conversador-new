import 'package:flutter/material.dart';

class Rectangle extends BoxDecoration {
  static const int ID = 1;

  Rectangle({@required Color color, Color borderColor}) : super(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      border: (borderColor != null) ? Border.all(
        color: borderColor,
        width: 1.0,
      ) : null,
  );
}
