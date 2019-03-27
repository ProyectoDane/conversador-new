import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/figure/figure.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

class Piece {

  Piece({@required this.concept, @required this.index});

  static const double BASE_SIZE = 90;

  static const int TARGET_INITIAL = 1;
  static const int TARGET_COMPLETED = 2;
  static const int DRAG_INITIAL = 3;
  static const int DRAG_FEEDBACK = 4;
  static const int DRAG_COMPLETED = 5;

  final Concept concept;
  final int index;


  Widget buildWidget({
    @required int pieceType,
    @required PieceConfig pieceConfig,
    double size = BASE_SIZE
  }) {
    final Figure figure = pieceConfig.createFigure(concept.type, pieceType);
    return figure.buildWidget(
        pieceType: pieceType,
        content: concept.value,
        size: size
    );
  }
}
