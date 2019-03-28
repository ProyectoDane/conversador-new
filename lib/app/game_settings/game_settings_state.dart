import 'package:tuple/tuple.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

/// State for GameSettingsPage
/// Saves the difficulties to show and if they are activated or not.
class GameSettingsState {

  /// Creates the state based on the difficulties and their enabling.
  GameSettingsState(this.difficulties);

  /// List of (difficulty and if it's selected).
  final List<Tuple2<GameDifficulty, bool>> difficulties;

  /// Returns new state based on this one,
  /// but activating the given difficulty.
  GameSettingsState activate(GameDifficulty difficulty) {
    final int i = difficulties.indexWhere(
      (Tuple2<GameDifficulty, bool> tuple) => tuple.item1 == difficulty
    );
    final List<Tuple2<GameDifficulty, bool>> newDifficulties =
      List<Tuple2<GameDifficulty, bool>>.of(difficulties);
    if (i != -1 && !difficulties[i].item2) {
      newDifficulties[i] = Tuple2<GameDifficulty, bool>(difficulty, true);
    }
    return GameSettingsState(newDifficulties);
  }

  /// Returns new state based on this one,
  /// but deactivating the given difficulty.
  GameSettingsState deactivate(GameDifficulty difficulty) {
    final int i = difficulties.indexWhere(
      (Tuple2<GameDifficulty, bool> tuple) => tuple.item1 == difficulty
    );
    final List<Tuple2<GameDifficulty, bool>> newDifficulties =
      List<Tuple2<GameDifficulty, bool>>.of(difficulties);
    if (i != -1 && difficulties[i].item2) {
      newDifficulties[i] = Tuple2<GameDifficulty, bool>(difficulty, false);
    }
    return GameSettingsState(newDifficulties);
  }

}
