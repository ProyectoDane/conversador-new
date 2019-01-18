import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class RadiusAnimation {
  static Widget animate({
    @required Animation<double> sizeAnimation,
    @required Piece piece,
    @required ShapeConfig shapeConfig,
  }) {
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
                decoration: _getDecoration(
                  piece: piece,
                  pieceType: Piece.TARGET_COMPLETED,
                  shapeConfig: shapeConfig,
                ),
              ),
              piece.buildWidget(pieceType: Piece.TARGET_INITIAL, shapeConfig: shapeConfig), // Text
            ],
          ),
        );
      },
    );
  }

  static Decoration _getDecoration({
    @required Piece piece,
    @required int pieceType,
    @required ShapeConfig shapeConfig,
  }) {
    final conceptType = piece.concept.type;
    final baseColor = shapeConfig.colorByConceptType()[conceptType];
    final color = shapeConfig.colorByPieceType(baseColor)[pieceType];
    final shape = shapeConfig.shapeByConceptType(color)[conceptType];
    return shape.decoration;
  }
}
