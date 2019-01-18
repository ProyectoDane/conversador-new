import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/thing.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class ColorDifficulty extends GameDifficulty {
  final Function colorByConceptType = () => {
        Subject.ID: Colors.grey,
        Action.ID: Colors.grey,
        Modifier.ID: Colors.grey,
        Thing.ID: Colors.grey,
      };

  @override
  ShapeConfig apply(ShapeConfig shapeConfig) => ShapeConfig(
        colorByConceptType: colorByConceptType,
        colorByPieceType: shapeConfig.colorByPieceType,
        shapeByConceptType: shapeConfig.shapeByConceptType,
      );
}
