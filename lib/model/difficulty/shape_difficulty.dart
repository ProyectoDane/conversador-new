import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate_core.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject_core.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/decorators/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class ShapeDifficulty extends GameDifficulty {
  final Function shapeByConceptType = (Color color) => {
        Subject.ID: Shape(decoration: Rectangle(color)),
        SubjectCore.ID: Shape(decoration: Rectangle(color)),
        Predicate.ID: Shape(decoration: Rectangle(color)),
        PredicateCore.ID: Shape(decoration: Rectangle(color)),
        Modifier.ID: Shape(decoration: Rectangle(color)),
        Complement.ID: Shape(decoration: Rectangle(color)),
      };

  @override
  ShapeConfig apply(ShapeConfig shapeConfig) =>
      ShapeConfig.cloneWithAssign(shapeConfig: shapeConfig, shapeByConceptType: shapeByConceptType);
}
