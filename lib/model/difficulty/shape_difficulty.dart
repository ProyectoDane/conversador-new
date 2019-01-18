import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/thing.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/decorators/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class ShapeDifficulty extends GameDifficulty {
  final Function shapeByConceptType = (Color color) => {
        Subject.ID: Shape(decoration: Rectangle(color)),
        Action.ID: Shape(decoration: Rectangle(color)),
        Modifier.ID: Shape(decoration: Rectangle(color)),
        Thing.ID: Shape(decoration: Rectangle(color)),
      };

  @override
  ShapeConfig apply(ShapeConfig shapeConfig) => ShapeConfig(
        colorByConceptType: shapeConfig.colorByConceptType,
        colorByPieceType: shapeConfig.colorByPieceType,
        shapeByConceptType: shapeByConceptType,
      );
}
