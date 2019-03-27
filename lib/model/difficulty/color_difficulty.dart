import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

class ColorDifficulty extends GameDifficulty {
  static const String NAME = 'ColorDifficulty';

  @override
  String get name => NAME;

  Map<int, Color> colorByConceptType() => <int, Color>{
        Subject.TYPE: Colors.grey,
        Entity.TYPE: Colors.grey,
        Predicate.TYPE: Colors.grey,
        Action.TYPE: Colors.grey,
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
