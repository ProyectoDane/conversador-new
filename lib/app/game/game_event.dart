import 'package:flutter_syntactic_sorter/app/game/game_state.dart';

abstract class GameEvent {
  final Future<GameState> Function (GameState) mutateState;

  GameEvent(this.mutateState);
}

class StartStage extends GameEvent {
  StartStage(Future<GameState> Function(GameState) mutateState): super(mutateState);
}

class LiveStageCompleted extends GameEvent {
  LiveStageCompleted(Future<GameState> Function(GameState) mutateState): super(mutateState);
}
