import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/decorators/circle.dart';
import 'package:flutter_syntactic_sorter/model/shape/decorators/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class ShapeConfig {
  final Function colorByConceptType;
  final Function shapeByConceptType;
  final Function colorByPieceType;

  ShapeConfig({this.colorByConceptType, this.shapeByConceptType, this.colorByPieceType});

  static ShapeConfig cloneWithAssign(
          {ShapeConfig shapeConfig,
          Function colorByConceptType,
          Function shapeByConceptType,
          Function colorByPieceType}) =>
      ShapeConfig(
        colorByConceptType: colorByConceptType == null ? shapeConfig.colorByConceptType : colorByConceptType,
        shapeByConceptType: shapeByConceptType == null ? shapeConfig.shapeByConceptType : shapeByConceptType,
        colorByPieceType: colorByPieceType == null ? shapeConfig.colorByPieceType : colorByPieceType,
      );

  static ShapeConfig getDefaultConfig() => ShapeConfig(
        colorByConceptType: ShapeConfig.defaultColorByConceptType,
        shapeByConceptType: ShapeConfig.defaultShapeByConceptType,
        colorByPieceType: ShapeConfig.defaultColorByPieceType,
      );

  static Function defaultColorByConceptType = () => {
        Subject.TYPE: Colors.green,
        Entity.TYPE: Colors.green,
        Predicate.TYPE: Colors.red,
        Action.TYPE: Colors.red,
        Modifier.TYPE: Colors.blue,
        Complement.TYPE: Colors.orange,
      };

  static Function defaultShapeByConceptType = (Color color) => {
        Subject.TYPE: Shape(decoration: Rectangle(color)),
        Entity.TYPE: Shape(decoration: Rectangle(color)),
        Predicate.TYPE: Shape(decoration: Circle(color)),
        Action.TYPE: Shape(decoration: Circle(color)),
        Modifier.TYPE: Shape(decoration: Rectangle(color)),
        Complement.TYPE: Shape(decoration: Circle(color)),
      };

  static Function defaultColorByPieceType = (Color color) => {
        Piece.TARGET_INITIAL: Colors.black26,
        Piece.TARGET_COMPLETED: color,
        Piece.DRAG_INITIAL: color,
        Piece.DRAG_FEEDBACK: color.withOpacity(0.5),
        Piece.DRAG_COMPLETED: color.withOpacity(0.5),
      };

  static ShapeConfig applyDifficulties(ShapeConfig shapeConfig, List<GameDifficulty> difficulties) {
    ShapeConfig baseConfig = shapeConfig;
    for (GameDifficulty difficulty in difficulties) {
      baseConfig = difficulty.apply(baseConfig);
    }
    return baseConfig;
  }

  Shape createShape(int conceptType, int pieceType) {
    final colorByConcept = colorByConceptType()[conceptType];
    final colorByPiece = colorByPieceType(colorByConcept)[pieceType];
    return shapeByConceptType(colorByPiece)[conceptType];
  }
}
