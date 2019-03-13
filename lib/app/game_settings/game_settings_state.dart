import 'package:tuple/tuple.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

class GameSettingsState {
  // Difficulty and if it's selected.
  final List<Tuple2<GameDifficulty, bool>> difficulties;

  GameSettingsState(this.difficulties);

  GameSettingsState activate(GameDifficulty difficulty) {
    final i = difficulties.indexWhere((tuple) => tuple.item1 == difficulty);
    List<Tuple2<GameDifficulty, bool>> newDifficulties = List.of(difficulties);
    if (i != -1 && !difficulties[i].item2) {
      newDifficulties[i] = Tuple2(difficulty, true);
    }
    return GameSettingsState(newDifficulties);
  }

  GameSettingsState deactivate(GameDifficulty difficulty) {
    final i = difficulties.indexWhere((tuple) => tuple.item1 == difficulty);
    List<Tuple2<GameDifficulty, bool>> newDifficulties = List.of(difficulties);
    if (i != -1 && difficulties[i].item2) {
      newDifficulties[i] = Tuple2(difficulty, false);
    }
    return GameSettingsState(newDifficulties);
  }

}
