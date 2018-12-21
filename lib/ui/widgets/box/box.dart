import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

abstract class Box extends StatefulWidget {
  static const double GROW_PERCENTAGE = 1.1;
  static const double FONT_SIZE = 15.0;
  static const double FONT_SIZE_FEEDBACK = FONT_SIZE * GROW_PERCENTAGE;
  static const double BOX_SIZE = 80.0;
  static const double TARGET_BOX_SIZE = BOX_SIZE;
  static const double TARGET_BOX_SIZE_COMPLETE = TARGET_BOX_SIZE * GROW_PERCENTAGE;
  static const double TARGET_BOX_SIZE_START = TARGET_BOX_SIZE * 0.6;
  static const double DRAGGABLE_BOX_SIZE = BOX_SIZE;
  static const double DRAGGABLE_BOX_SIZE_FEEDBACK = DRAGGABLE_BOX_SIZE * GROW_PERCENTAGE;
  static const int ANIMATION_DURATION_MS = 1500;

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