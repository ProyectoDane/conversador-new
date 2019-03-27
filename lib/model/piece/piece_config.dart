import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/figure/figure.dart';

class PieceConfig {
  PieceConfig({
    this.colorByConceptType,
    this.shapeByConceptType,
    this.colorByPieceType
  });

  PieceConfig.cloneWithAssign({
    PieceConfig pieceConfig,
    Map<int, Color> Function() colorByConceptType,
    Map<int, Decoration> Function(Color) shapeByConceptType,
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

  PieceConfig.getDefaultConfig() :
        colorByConceptType =PieceConfig.defaultColorByConceptType,
        shapeByConceptType = PieceConfig.defaultShapeByConceptType,
        colorByPieceType = PieceConfig.defaultColorByPieceType;

  final Map<int, Color> Function() colorByConceptType;
  final Map<int, Decoration> Function(Color) shapeByConceptType;
  final Map<int, Color> Function(Color) colorByPieceType;


  static Map<int, Color> defaultColorByConceptType() => <int, Color>{
        Subject.TYPE: Colors.green,
        Entity.TYPE: Colors.green,
        Predicate.TYPE: Colors.red,
        Action.TYPE: Colors.red,
        Modifier.TYPE: Colors.blue,
        Complement.TYPE: Colors.orange,
      };

  static Map<int, Decoration> defaultShapeByConceptType(final Color color) =>
      <int, Decoration>{
        Subject.TYPE: Rectangle(color: color),
        Entity.TYPE: Rectangle(color: color),
        Predicate.TYPE: Circle(color),
        Action.TYPE: Circle(color),
        Modifier.TYPE: Rectangle(color: color),
        Complement.TYPE: Circle(color),
      };

  static Map<int, Color> defaultColorByPieceType(final Color color) =>
      <int, Color>{
        Piece.TARGET_INITIAL: Colors.black26,
        Piece.TARGET_COMPLETED: color,
        Piece.DRAG_INITIAL: color,
        Piece.DRAG_FEEDBACK: color.withOpacity(0.5),
        Piece.DRAG_COMPLETED: color.withOpacity(0.5),
      };

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

  Figure createFigure(final int conceptType, final int pieceType) {
    final Color colorByConcept = colorByConceptType()[conceptType];
    final Color colorByPiece = colorByPieceType(colorByConcept)[pieceType];
    return Figure(decoration: shapeByConceptType(colorByPiece)[conceptType]);
  }

}
