import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

/// GameModeDifficulty based on eliminating any color segmentation that
/// may help the user relate concepts easier.
class ColorDifficulty extends GameModeDifficulty {

  /// This GameModeDifficulty type name
  static const String NAME = 'ColorDifficulty';

  @override
  String get name => NAME;

  /// Function that returns the color related to each concept
  /// according to this difficulty.
  Map<int, Color> colorByConceptType() => <int, Color>{
        Subject.TYPE: Colors.grey,
        Entity.TYPE: Colors.grey,
        Predicate.TYPE: Colors.grey,
        ActionVerb.TYPE: Colors.grey,
        Modifier.TYPE: Colors.grey,
        Complement.TYPE: Colors.grey,
      };

  @override
  PieceConfig apply(final PieceConfig pieceConfig) =>
      PieceConfig.cloneWithAssign(
          pieceConfig: pieceConfig,
          colorByConceptType: colorByConceptType
      );

  @override
  String get imageUri => 'assets/images/game_settings/colors.png';

  @override
  bool operator==(dynamic other) => other is ColorDifficulty;

  @override
  int get hashCode => imageUri.hashCode;

}
