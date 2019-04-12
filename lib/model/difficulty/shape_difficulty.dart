import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/rectangle_painter.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/shape_painter.dart';

/// GameDifficulty based on eliminating any shape segmentation that
/// may help the user relate concepts easier.
class ShapeDifficulty extends GameDifficulty {

  /// This GameDifficulty type name
  static const String NAME = 'ShapeDifficulty';

  @override
  String get name => NAME;

  /// Function that returns the shape related to each concept
  /// according to this difficulty.
  Map<int, ShapePainter> painterByConceptType (Color color) =>
      <int, ShapePainter>{
        Subject.TYPE: RectanglePainter(color),
        Entity.TYPE: RectanglePainter(color),
        Predicate.TYPE: RectanglePainter(color),
        Action.TYPE: RectanglePainter(color),
        Modifier.TYPE: RectanglePainter(color),
        Complement.TYPE: RectanglePainter(color),
      };

  @override
  PieceConfig apply(final PieceConfig pieceConfig) =>
      PieceConfig.cloneWithAssign(
          pieceConfig: pieceConfig,
          painterByConceptType: painterByConceptType
      );

  @override
  String get imageUri => 'assets/images/game_settings/shapes.png';

  @override
  bool operator==(dynamic other) => other is ShapeDifficulty;

  @override
  int get hashCode => imageUri.hashCode;

}
