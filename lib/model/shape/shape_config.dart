import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate_core.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject_core.dart';
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
        Subject.ID: Colors.green,
        SubjectCore.ID: Colors.green,
        Predicate.ID: Colors.red,
        PredicateCore.ID: Colors.red,
        Modifier.ID: Colors.blue,
        Complement.ID: Colors.orange,
      };

  static Function defaultShapeByConceptType = (Color color) => {
        Subject.ID: Shape(decoration: Rectangle(color)),
        SubjectCore.ID: Shape(decoration: Rectangle(color)),
        Predicate.ID: Shape(decoration: Circle(color)),
        PredicateCore.ID: Shape(decoration: Circle(color)),
        Modifier.ID: Shape(decoration: Rectangle(color)),
        Complement.ID: Shape(decoration: Circle(color)),
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
