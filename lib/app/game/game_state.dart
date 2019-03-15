import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';

class GameState {
  final bool loading;
  final String backgroundUri;
  final LiveStageBloc liveStageBloc;

  GameState(this.loading, this.backgroundUri, this.liveStageBloc);

  factory GameState.loading() => GameState(true, '', null);
}

