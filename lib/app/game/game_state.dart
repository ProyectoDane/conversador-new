import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';

/// State for GamePage.
/// It stores information for what the current stage is
/// or even if we are still loading a stage.
/// And it passes on a LiveStageBloc to take care of
/// the current stage's current level.
class GameState {

  /// Create a GameState with the background image Uri,
  /// whether we are loading a stage,
  /// and the live stage bloc.
  GameState({this.loading, this.backgroundUri, this.liveStageBloc});

  /// Creates a GameState in the loading state which does not
  /// have a background image or a corresponding live stage bloc.
  GameState.loading() :
    loading = true,
    backgroundUri = '',
    liveStageBloc = null;

  /// Whether we are loading a stage or not
  final bool loading;
  /// The background image uri
  final String backgroundUri;
  /// LiveStageBloc handling the current stage's current level.
  final LiveStageBloc liveStageBloc;

}

