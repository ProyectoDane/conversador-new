import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

/// Difficulty added to the game so that the user
/// has a harder time trying to solve the game.
abstract class GameModeDifficulty {
  /// Function that return a new PieceConfig based on
  /// the given one and the difficulty tweaks to it
  PieceConfig apply(final PieceConfig pieceConfig);

  /// Uri for image that represents what the game
  /// would look like without this difficulty
  String get imageUri;

  /// Name of the difficulty
  String name;

  /// Text description
  String get textDescription;

  /// Returns the GameModeDifficulty associated with the given name
  /// or null if the name is invalid.
  static GameModeDifficulty fromName(String name) {
    if (ColorDifficulty.NAME == name) {
      return ColorDifficulty();
    }
    if (ShapeDifficulty.NAME == name) {
      return ShapeDifficulty();
    }
    return null;
  }
}
