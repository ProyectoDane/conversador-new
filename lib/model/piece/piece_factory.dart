import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/thing.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';
import 'package:flutter_syntactic_sorter/ui/settings/difficulty/game_difficulty.dart';

class PieceFactory {
  static List<Piece> getPieces(List<Concept> concepts, GameDifficulty gameDifficulty) {
    return concepts.map((concept) => _getPiece(concept, gameDifficulty)).toList();
  }

  static Piece _getPiece(Concept concept, GameDifficulty gameDifficulty) {
    final diff = gameDifficulty.computeDiff();
    return Piece(
      content: concept.value,
      shape: _shapeByType[diff][concept.id],
    );
  }

  static Map<int, Map<int, Shape>> _shapeByType = {
    GameDifficulty.NO_SHAPES_AND_NO_COLORS: {
      Subject.ID: Rectangle(color: Colors.grey),
      Action.ID: Rectangle(color: Colors.grey),
      Modifier.ID: Rectangle(color: Colors.grey),
      Thing.ID: Rectangle(color: Colors.grey),
    },
    GameDifficulty.NO_SHAPES_AND_COLORS: {
      Subject.ID: Rectangle(color: Colors.green),
      Action.ID: Rectangle(color: Colors.red),
      Modifier.ID: Rectangle(color: Colors.blue),
      Thing.ID: Rectangle(color: Colors.orange),
    },
    GameDifficulty.SHAPES_AND_NO_COLORS: {
      Subject.ID: Rectangle(color: Colors.grey),
      Action.ID: Circle(color: Colors.grey),
      Modifier.ID: Rectangle(color: Colors.grey),
      Thing.ID: Circle(color: Colors.grey),
    },
    GameDifficulty.SHAPES_AND_COLORS: {
      Subject.ID: Rectangle(color: Colors.green),
      Action.ID: Circle(color: Colors.red),
      Modifier.ID: Rectangle(color: Colors.blue),
      Thing.ID: Circle(color: Colors.orange),
    },
  };
}
