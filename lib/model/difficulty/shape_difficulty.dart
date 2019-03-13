import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/decorators/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class ShapeDifficulty extends GameDifficulty {
  final Function shapeByConceptType = (Color color) => {
        Subject.TYPE: Shape(decoration: Rectangle(color)),
        Entity.TYPE: Shape(decoration: Rectangle(color)),
        Predicate.TYPE: Shape(decoration: Rectangle(color)),
        Action.TYPE: Shape(decoration: Rectangle(color)),
        Modifier.TYPE: Shape(decoration: Rectangle(color)),
        Complement.TYPE: Shape(decoration: Rectangle(color)),
      };

  @override
  ShapeConfig apply(final ShapeConfig shapeConfig) =>
      ShapeConfig.cloneWithAssign(shapeConfig: shapeConfig, shapeByConceptType: shapeByConceptType);

  @override
  String get imageUri => 'assets/images/game_settings/shapes.png';

  @override
  bool operator==(o) => o is ShapeDifficulty;

  @override
  int get hashCode => imageUri.hashCode;

}
