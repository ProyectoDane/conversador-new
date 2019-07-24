import 'package:flutter_syntactic_sorter/app/game/game_state.dart';

/// Events for GameBloc
/// The Bloc creates them with the corresponding
/// state mutating function.
abstract class GameEvent {
  /// Creates the GameEvent with its
  /// corresponding state mutating function
  GameEvent(this.mutateState);

  /// Function that holds the know-how on how
  /// to get the new state from the old one.
  final Stream<GameState> Function(GameState) mutateState;
}

/// Event to dispatch when the view has been loaded for the first time
/// and the first stage should be loaded.
class StartStage extends GameEvent {
  /// Creates the StartStage GameEvent with its
  /// corresponding state mutating function
  StartStage(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}

/// Event dispatched when the user has completed the current
/// stage in a level and so the end buttons must be displayed.
class LiveStageCompleted extends GameEvent {
  /// Creates the LiveStageCompleted GameEvent with its
  /// corresponding state mutating function
  LiveStageCompleted(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}

/// Event to load the following stage within the level
class LoadNextStage extends GameEvent {
  /// Creates LoadNextStage Game event with its
  /// corresponding state mutating function
  LoadNextStage(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}

/// Event dispatched once the user decides to continue to next level
class LevelCompleted extends GameEvent {
  /// Creates the LevelCompleted GameEvent with its
  /// corresponding state mutating function
  LevelCompleted(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}
