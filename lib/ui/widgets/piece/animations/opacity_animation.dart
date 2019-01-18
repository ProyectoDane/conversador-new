import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/radius_animation.dart';

class OpacityAnimation {
  static Widget animate({
    @required Animation<double> opacityAnimation,
    @required Animation<double> sizeAnimation,
    @required Piece piece,
    @required ShapeConfig shapeConfig,
  }) {
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: 1 - opacityAnimation.value,
          child: RadiusAnimation.animate(sizeAnimation: sizeAnimation, piece: piece, shapeConfig: shapeConfig),
        );
      },
    );
  }
}
