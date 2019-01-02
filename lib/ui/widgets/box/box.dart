import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

abstract class Box extends StatefulWidget {
  static const double FONT_SIZE = 15.0;
  static const double SIZE = 80.0;
  static const double MAX_RADIUS = 5.0;
  static const Color COLOR = Colors.black12;

  final Offset initPosition;
  final Word word;

  Box({@required this.initPosition, @required this.word});

  Widget buildBox({double size = SIZE, double fontSize = FONT_SIZE, Color boxColor = COLOR}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.all(Radius.circular(MAX_RADIUS))),
      child: Center(
        child: Text(
          word.value,
          style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: fontSize),
        ),
      ),
    );
  }
}
