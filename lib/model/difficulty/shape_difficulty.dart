import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

class ShapeDifficulty extends GameDifficulty {

  static final NAME = "ShapeDifficulty";
  String get name => NAME;

  final Map<int, BoxDecoration> Function(Color) shapeByConceptType = (Color color) => {
        Subject.TYPE: Rectangle(color: color),
        Entity.TYPE: Rectangle(color: color),
        Predicate.TYPE: Rectangle(color: color),
        Action.TYPE: Rectangle(color: color),
        Modifier.TYPE: Rectangle(color: color),
        Complement.TYPE: Rectangle(color: color),
      };

  @override
  PieceConfig apply(final PieceConfig pieceConfig) =>
      PieceConfig.cloneWithAssign(pieceConfig: pieceConfig, shapeByConceptType: shapeByConceptType);

  @override
  String get imageUri => 'assets/images/game_settings/shapes.png';

  @override
  bool operator==(dynamic o) => o is ShapeDifficulty;

  @override
  int get hashCode => imageUri.hashCode;

}
