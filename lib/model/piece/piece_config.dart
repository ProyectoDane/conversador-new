import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/figure/figure.dart';

/// Piece configuration.
/// It stores the information needed to define
/// the Piece's figure (shape + color)
class PieceConfig {

  /// Crates the Piece config based on 3 functions:
  /// - one that defines the color by concept type
  /// - one for the shape based on concept type, built from a color
  /// - one for the color modification by piece type
  PieceConfig({
    this.colorByConceptType,
    this.shapeByConceptType,
    this.colorByPieceType
  });

  /// Creates a Piece Config based on another piece config
  /// and optionally the function to modify.
  PieceConfig.cloneWithAssign({
    @required PieceConfig pieceConfig,
    Map<int, Color> Function() colorByConceptType,
    Map<int, Shape> Function(Color) shapeByConceptType,
    Map<int, Color> Function(Color) colorByPieceType}) :
      colorByConceptType = colorByConceptType == null
            ? pieceConfig.colorByConceptType
            : colorByConceptType,
      shapeByConceptType = shapeByConceptType == null
          ? pieceConfig.shapeByConceptType
          : shapeByConceptType,
      colorByPieceType = colorByPieceType == null
          ? pieceConfig.colorByPieceType
          : colorByPieceType;

  /// Function that defines which color
  /// should be used based on the concept type
  final Map<int, Color> Function() colorByConceptType;
  /// Function that given a color defines
  /// which shape should be used and filled with that color
  /// based on the concept type
  final Map<int, Shape> Function(Color) shapeByConceptType;
  /// Function that defines given a color what final
  /// color should be used given the piece type's
  /// necessary modifications
  final Map<int, Color> Function(Color) colorByPieceType;

  /// Returns a new PieceConfig based on the given one
  /// and the difficulties that have to be applied to it.
  static PieceConfig applyDifficulties(
    final PieceConfig pieceConfig,
    final List<GameDifficulty> difficulties
  ) {
    PieceConfig baseConfig = pieceConfig;
    for (final GameDifficulty difficulty in difficulties) {
      baseConfig = difficulty.apply(baseConfig);
    }
    return baseConfig;
  }

  /// Returns the figure that should be used
  /// for the concept and piece type specified.
  Figure createFigure(final int conceptType, final int pieceType) {
    final Color colorByConcept = colorByConceptType()[conceptType];
    final Color colorByPiece = colorByPieceType(colorByConcept)[pieceType];
    return Figure(decoration: shapeByConceptType(colorByPiece)[conceptType]);
  }

  /// Returns the decoration that should be used
  /// for the concept and piece type specified.
  Decoration createDecoration(final int conceptType, final int pieceType) {
    final Color colorByConcept = colorByConceptType()[conceptType];
    final Color colorByPiece = colorByPieceType(colorByConcept)[pieceType];
    return shapeByConceptType(colorByPiece)[conceptType];
  }

}
