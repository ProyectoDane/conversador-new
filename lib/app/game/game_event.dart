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
  final Stream<GameState> Function (GameState) mutateState;

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
/// level in a stage and so a new one must be loaded.
class LiveStageCompleted extends GameEvent {
  /// Creates the LiveStageCompleted GameEvent with its
  /// corresponding state mutating function
  LiveStageCompleted(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}

class LevelCompleted extends GameEvent {
  LevelCompleted(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}