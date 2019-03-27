import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';

class GameState {

  GameState({this.loading, this.backgroundUri, this.liveStageBloc});
  factory GameState.loading() => GameState(
      loading: true,
      backgroundUri: '',
      liveStageBloc: null);

  final bool loading;
  final String backgroundUri;
  final LiveStageBloc liveStageBloc;

}

