import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

class ColorDifficulty extends GameDifficulty {
  final Function colorByConceptType = () => {
        Subject.TYPE: Colors.grey,
        Entity.TYPE: Colors.grey,
        Predicate.TYPE: Colors.grey,
        Action.TYPE: Colors.grey,
        Modifier.TYPE: Colors.grey,
        Complement.TYPE: Colors.grey,
      };

  @override
  ShapeConfig apply(final ShapeConfig shapeConfig) =>
      ShapeConfig.cloneWithAssign(shapeConfig: shapeConfig, colorByConceptType: colorByConceptType);

  @override
  String get imageUri => 'assets/images/game_settings/colors.png';

  @override
  bool operator==(o) => o is ColorDifficulty;

  @override
  int get hashCode => imageUri.hashCode;


}
