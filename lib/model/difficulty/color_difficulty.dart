import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate_core.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject_core.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class ColorDifficulty extends GameDifficulty {
  final Function colorByConceptType = () => {
        Subject.ID: Colors.grey,
        SubjectCore.ID: Colors.grey,
        Predicate.ID: Colors.grey,
        PredicateCore.ID: Colors.grey,
        Modifier.ID: Colors.grey,
        Complement.ID: Colors.grey,
      };

  @override
  ShapeConfig apply(ShapeConfig shapeConfig) =>
      ShapeConfig.cloneWithAssign(shapeConfig: shapeConfig, colorByConceptType: colorByConceptType);
}
