import 'package:tuple/tuple.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

/// State for GameSettingsPage
/// Saves the difficulties to show and if they are activated or not.
class GameSettingsState {

  /// Creates the state based on the difficulties and their enabling.
  GameSettingsState(this.difficulties);

  /// List of (difficulty and if it's selected).
  final List<Tuple2<GameModeDifficulty, bool>> difficulties;

  /// Returns new state based on this one,
  /// but activating the given difficulty.
  GameSettingsState activate(GameModeDifficulty difficulty) {
    final int i = difficulties.indexWhere(
      (Tuple2<GameModeDifficulty, bool> tuple) => tuple.item1 == difficulty
    );
    final List<Tuple2<GameModeDifficulty, bool>> newDifficulties =
      List<Tuple2<GameModeDifficulty, bool>>.of(difficulties);
    if (i != -1 && !difficulties[i].item2) {
      newDifficulties[i] = Tuple2<GameModeDifficulty, bool>(difficulty, true);
    }
    return GameSettingsState(newDifficulties);
  }

  /// Returns new state based on this one,
  /// but deactivating the given difficulty.
  GameSettingsState deactivate(GameModeDifficulty difficulty) {
    final int i = difficulties.indexWhere(
      (Tuple2<GameModeDifficulty, bool> tuple) => tuple.item1 == difficulty
    );
    final List<Tuple2<GameModeDifficulty, bool>> newDifficulties =
      List<Tuple2<GameModeDifficulty, bool>>.of(difficulties);
    if (i != -1 && difficulties[i].item2) {
      newDifficulties[i] = Tuple2<GameModeDifficulty, bool>(difficulty, false);
    }
    return GameSettingsState(newDifficulties);
  }

}
