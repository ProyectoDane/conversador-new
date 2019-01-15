import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

// TODO improve all this, maybe use map
class PieceFactory {
  static List<Piece> getPieces(List<Concept> concepts) {
    final List<Piece> pieces = [];
    for (Concept concept in concepts) {
      pieces.add(_getPiece(concept));
    }
    return pieces;
  }

  static Piece _getPiece(Concept concept) {
    return Piece(
      concept: concept.value,
      shape: _getShape(concept.type),
    );
  }

  static Shape _getShape(int type) {
    switch (type) {
      case Subject.TYPE:
        return Rectangle(
          color: _getShapeColor(type),
        );
      case Action.TYPE:
        return Circle(
          color: _getShapeColor(type),
        );
      case Modifier.TYPE:
      default:
        return Rectangle(
          color: _getShapeColor(type),
        );
    }
  }

  static Color _getShapeColor(type) {
    switch (type) {
      case Subject.TYPE:
        return Colors.green;
      case Action.TYPE:
        return Colors.red;
      case Modifier.TYPE:
      default:
        return Colors.blue;
    }
  }
}
