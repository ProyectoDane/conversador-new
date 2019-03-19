import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

class RadiusAnimation {
  static Widget animate({
    @required final Animation<double> sizeAnimation,
    @required final Piece piece,
    @required final PieceConfig pieceConfig,
  }) =>
      AnimatedBuilder(
        animation: sizeAnimation,
        builder: (BuildContext context, Widget child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                  decoration: _getDecoration(
                    piece: piece,
                    pieceType: Piece.TARGET_COMPLETED,
                    pieceConfig: pieceConfig,
                  ),
                ),
                piece.buildWidget(pieceType: Piece.TARGET_INITIAL, pieceConfig: pieceConfig),
              ],
            ),
          );
        },
      );

  static Decoration _getDecoration({
    @required final Piece piece,
    @required final int pieceType,
    @required final PieceConfig pieceConfig,
  }) {
    final conceptType = piece.concept.type;
    final baseColor = pieceConfig.colorByConceptType()[conceptType];
    final color = pieceConfig.colorByPieceType(baseColor)[pieceType];
    final shape = pieceConfig.shapeByConceptType(color)[conceptType];
    return shape;
  }
}
