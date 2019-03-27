import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/radius_animation.dart';

class OpacityAnimation {
  static Widget animate(
          {@required final Animation<double> opacityAnimation,
          @required final Animation<double> sizeAnimation,
          @required final Piece piece,
          @required final PieceConfig pieceConfig}) =>
      AnimatedBuilder(
        animation: opacityAnimation,
        builder: (BuildContext context, Widget child) =>
          Opacity(
            opacity: 1 - opacityAnimation.value,
            child: RadiusAnimation.animate(
                sizeAnimation: sizeAnimation,
                piece: piece,
                pieceConfig: pieceConfig
            ),
          )
      );
}
