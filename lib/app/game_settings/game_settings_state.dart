import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

/// State for GameSettingsPage
/// Saves the difficulties to show and if they are activated or not.
class GameSettingsState {

  /// Creates the state based on the difficulties and their enabling.
  GameSettingsState(this.difficulties, 
                    this.stages,
                    this.isShowingStages);

  /// List of (difficulty and if it's selected).
  final List<Tuple2<GameModeDifficulty, bool>> difficulties;

  /// Stages for stage selection (ready only)
  final List<Stage> stages;
  /// Is showing stages list or not
  final bool isShowingStages;

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
    return GameSettingsState(
      newDifficulties, stages, isShowingStages);
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
    return GameSettingsState(
      newDifficulties, stages, isShowingStages);
  }

  /// Returns state with updated stage list
  GameSettingsState updateStages(List<Stage> stages)
    => GameSettingsState(difficulties, stages, isShowingStages);

  /// Returns stage with stage list visibility
  GameSettingsState toggleStageListVisibility()
    => GameSettingsState(difficulties, stages, !isShowingStages);
}
