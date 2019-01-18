import 'package:flutter/material.dart';

class Rectangle extends BoxDecoration {
  static const int ID = 1;

  Rectangle(Color color) : super(color: color, borderRadius: BorderRadius.all(Radius.circular(5.0)));
}
