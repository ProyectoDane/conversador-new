import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class PieceFactory {
  static Map<int, Shape> shapeByType = {
    Subject.TYPE: Rectangle(color: Colors.green),
    Action.TYPE: Circle(color: Colors.red),
    Modifier.TYPE: Rectangle(color: Colors.blue),
  };

  static List<Piece> getPieces(List<Concept> concepts) => concepts.map(_getPiece).toList();

  static Piece _getPiece(Concept concept) => Piece(
        content: concept.value,
        shape: shapeByType[concept.type],
      );
}
