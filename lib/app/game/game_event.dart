import 'package:flutter_syntactic_sorter/app/game/game_state.dart';

abstract class GameEvent {
  //TODO: We could look into returning a stream of states if we run into the need,
  // since the BLOC's mapEventToState returns a stream.
  final Stream<GameState> Function (GameState) mutateState;

  GameEvent(this.mutateState);
}

class StartStage extends GameEvent {
  StartStage(Stream<GameState> Function(GameState) mutateState): super(mutateState);
}

class LiveStageCompleted extends GameEvent {
  LiveStageCompleted(Stream<GameState> Function(GameState) mutateState): super(mutateState);
}
