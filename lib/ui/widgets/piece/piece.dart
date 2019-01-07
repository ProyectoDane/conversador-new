import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

abstract class Piece extends StatefulWidget {
  static const double FONT_SIZE = 15.0;
  static const double SIZE = 80.0;
  static const double MAX_RADIUS = 5.0;
  static const Color COLOR = Colors.black12;

  final Offset initPosition;
  final Word word;

  Piece({@required this.initPosition, @required this.word});

  Widget buildPiece({double size = SIZE, double fontSize = FONT_SIZE, Color color = COLOR, bool showText = true}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(MAX_RADIUS))),
      child: showText
          ? Center(
              child: Text(word.value,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: fontSize)),
            )
          : Container(),
    );
  }
}
