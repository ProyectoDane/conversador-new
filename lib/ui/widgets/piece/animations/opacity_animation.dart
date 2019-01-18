import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/radius_animation.dart';

class OpacityAnimation {
  static Widget animate(Animation<double> opacityAnimation, Animation<double> sizeAnimation, Piece piece) {
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: 1 - opacityAnimation.value,
          child: RadiusAnimation.animate(sizeAnimation, piece),
        );
      },
    );
  }
}
