import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

abstract class GameDifficulty {
  PieceConfig apply(final PieceConfig pieceConfig);
  String get imageUri;

  String name;

  static GameDifficulty fromName(String name) {
    if (ColorDifficulty.NAME == name) {
      return ColorDifficulty();
    }
    if (ShapeDifficulty.NAME == name) {
      return ShapeDifficulty();
    }
    return null;
  }
}
