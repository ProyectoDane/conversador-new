import 'package:tuple/tuple.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

class GameSettingsState {

  GameSettingsState(this.difficulties);

  // Difficulty and if it's selected.
  final List<Tuple2<GameDifficulty, bool>> difficulties;

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
