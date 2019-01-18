import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class RadiusAnimation {
  static Widget animate(Animation<double> sizeAnimation, Piece piece) {
    return AnimatedBuilder(
      animation: sizeAnimation,
      builder: (BuildContext context, Widget child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: sizeAnimation.value,
                height: sizeAnimation.value,
                decoration: piece.shape.getDecoration(Piece.TARGET_COMPLETED),
              ),
              piece.create(type: Piece.TARGET_INITIAL), // Text
            ],
          ),
        );
      },
    );
  }
}
