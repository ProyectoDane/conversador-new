import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

class Piece {
  static const double BASE_SIZE = 80.0;

  static const int TARGET_INITIAL = 1;
  static const int TARGET_COMPLETED = 2;
  static const int DRAG_INITIAL = 3;
  static const int DRAG_FEEDBACK = 4;
  static const int DRAG_COMPLETED = 5;

  final Concept concept;

  Piece({@required this.concept});

  Widget buildWidget({@required pieceType, @required shapeConfig, double size = BASE_SIZE}) {
    final shape = shapeConfig.createShape(concept.type, pieceType);
    return shape.buildWidget(pieceType: pieceType, content: concept.value, size: size);
  }
}
