import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_event.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/piece_config_repository.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';
import 'package:tuple/tuple.dart';

/// Bloc for the Game Settings
/// Handles the selection of the GameDifficulties
/// and saves them.
class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {

  /// Creates the bloc with the repository to save settings to.
  /// Repositories have a default value if passed null.
  GameSettingsBloc({PieceConfigRepository pieceRepository, 
                    StageRepository stageRepository}) {
      __pieceConfigRepository = pieceRepository ?? PieceConfigRepository();
      _stageRepository = stageRepository ?? StageRepository();
    } 

  PieceConfigRepository __pieceConfigRepository;
  StageRepository _stageRepository;

  @override
  GameSettingsState get initialState => GameSettingsState(
    <Tuple2<GameModeDifficulty, bool>>[
      Tuple2<GameModeDifficulty, bool>(ShapeDifficulty(), false),
      Tuple2<GameModeDifficulty, bool>(ColorDifficulty(), false),
    ],
    null,
    false
  );

  /// Called when view is shown for the first time
  void viewWasShown() {
    _preloadStages();
  }

  /// Loads stage list
  void _preloadStages() {
    _stageRepository.getAllPlainStageList().then((List<Stage> myStages) {
        dispatch(GameSettingsEvent.updatedStages(myStages));
    });
  }

  /// Change stage list visibility
  void toggleStagesVisibility() {
    dispatch(GameSettingsEvent.toggledStageList());
  }

  /// Save difficulties to repository.
  /// Called when user wants to save all changes.
  Future<bool> saveDifficulties() async =>
      __pieceConfigRepository.setPieceConfigAdditionals(
        currentState.difficulties
          .where((Tuple2<GameModeDifficulty, bool> tuple) => tuple.item2)
          .map((Tuple2<GameModeDifficulty, bool> tuple) => tuple.item1)
          .toList());

  /// Called when the user tapped on a difficulty to switch its enabled state.
  void tappedOnDifficulty(GameModeDifficulty difficulty) {
    final Tuple2<GameModeDifficulty, bool> tuple = currentState.difficulties
        .firstWhere((Tuple2<GameModeDifficulty, bool> tuple) =>
          tuple.item1 == difficulty
    );
    if (tuple.item2) {
      dispatch(GameSettingsEvent.deactivate(difficulty));
    } else {
      dispatch(GameSettingsEvent.activate(difficulty));
    }
  }

  @override
  Stream<GameSettingsState> mapEventToState(
      final GameSettingsState currentState,
      final GameSettingsEvent event
  ) async* {
    switch (event.type) {
      case GameSettingsEventType.difficultyActivated:
        yield currentState.activate(event.difficulty);
        break;
      case GameSettingsEventType.difficultyDeactivated:
        yield currentState.deactivate(event.difficulty);
        break;
      case GameSettingsEventType.stagesUpdated:
        yield currentState.updateStages(event.stages);
        break;
      case GameSettingsEventType.stageVisibilityToggled:
        yield currentState.toggleStageListVisibility();
    }
  }
}
