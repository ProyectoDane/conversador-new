import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/figure/figure.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

/// Represents a piece to show in the game (target or move around)
class Piece {

  /// Creates a Piece based on the concept it entails
  /// and the index where it's placed in relation to
  /// the other pieces os the same type.
  Piece({@required this.concept, @required this.index});

  /// Piece size
  static const double BASE_SIZE = 90;

  /// State of a target piece when available for match
  static const int TARGET_INITIAL = 1;
  /// State of a target piece was matched already
  static const int TARGET_COMPLETED = 2;
  /// State of a drag piece when available for
  /// match and waiting to be dragged
  static const int DRAG_INITIAL = 3;
  /// State of a drag piece when it's moving around
  static const int DRAG_FEEDBACK = 4;
  /// State of a drag piece when disabled,
  /// because of match or max failed attempts
  static const int DRAG_COMPLETED = 5;

  /// Concept this piece represents
  final Concept concept;
  /// Index of the piece in relation to others of the same type
  final int index;

  /// Function that builds the widget for the piece,
  /// based on the given piece configuration and size.
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

  /// Function that builds a Decoration to represent the piece
  /// based on the given piece configuration and size.
  Decoration buildDecoration({
    @required int pieceType,
    @required PieceConfig pieceConfig,
    double size = BASE_SIZE
  }) => pieceConfig.createDecoration(concept.type, pieceType);

}
