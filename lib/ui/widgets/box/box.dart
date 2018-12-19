import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

abstract class Box extends StatefulWidget {
  final Offset initPosition;
  final Word word;

  Box({
    @required this.initPosition,
    @required this.word,
  });

  Widget buildBox({@required double size, @required double fontSize, Color boxColor}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: boxColor == null ? word.color : boxColor,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Center(
        child: Text(
          word.value,
          style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: fontSize),
        ),
      ),
    );
  }
}