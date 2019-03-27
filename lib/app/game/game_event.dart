import 'package:flutter_syntactic_sorter/app/game/game_state.dart';

abstract class GameEvent {

  GameEvent(this.mutateState);

  final Stream<GameState> Function (GameState) mutateState;

}

class StartStage extends GameEvent {
  StartStage(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}

class LiveStageCompleted extends GameEvent {
  LiveStageCompleted(Stream<GameState> Function(GameState) mutateState)
      : super(mutateState);
}
