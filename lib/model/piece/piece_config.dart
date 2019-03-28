import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';
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

  /// PieceConfig built from default values.
  PieceConfig.getDefaultConfig() :
        colorByConceptType = PieceConfig.defaultColorByConceptType,
        shapeByConceptType = PieceConfig.defaultShapeByConceptType,
        colorByPieceType = PieceConfig.defaultColorByPieceType;

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

  /// Default colors based on concept type
  static Map<int, Color> defaultColorByConceptType() => <int, Color>{
        Subject.TYPE: Colors.green,
        Entity.TYPE: Colors.green,
        Predicate.TYPE: Colors.red,
        Action.TYPE: Colors.red,
        Modifier.TYPE: Colors.blue,
        Complement.TYPE: Colors.orange,
      };

  /// Default shapes based on concept type
  static Map<int, Shape> defaultShapeByConceptType(final Color color) =>
      <int, Shape>{
        Subject.TYPE: Rectangle(color: color),
        Entity.TYPE: Rectangle(color: color),
        Predicate.TYPE: Circle(color),
        Action.TYPE: Circle(color),
        Modifier.TYPE: Rectangle(color: color),
        Complement.TYPE: Circle(color),
      };

  /// Default colors based on piece type
  static Map<int, Color> defaultColorByPieceType(final Color color) =>
      <int, Color>{
        Piece.TARGET_INITIAL: Colors.black26,
        Piece.TARGET_COMPLETED: color,
        Piece.DRAG_INITIAL: color,
        Piece.DRAG_FEEDBACK: color.withOpacity(0.5),
        Piece.DRAG_COMPLETED: color.withOpacity(0.5),
      };

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

}
