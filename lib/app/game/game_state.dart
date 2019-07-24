import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:meta/meta.dart';

/// State for GamePage.
/// It stores information for what the current stage is
/// or even if we are still loading a stage.
/// And it passes on a LiveStageBloc to take care of
/// the current stage's current level.
class GameState {
  /// Create a GameState with the background image Uri,
  /// whether we are loading a stage,
  /// and the live stage bloc.
  GameState.stage({@required this.backgroundUri, @required this.liveStageBloc})
      : loading = false,
        isStageCompleted = false,
        levelCompleted = null,
        isFinalLevel = false;

  /// Creates a GameState in the loading state which does not
  /// have a background image or a corresponding live stage bloc.
  factory GameState.loading() =>
      GameState._internal(
          loading: true, backgroundUri: '', liveStageBloc: null);

  /// Creates a GameState that informs that the stage is complete
  factory GameState.stageComplete(
    {@required String backgroundUri, @required LiveStageBloc liveStageBloc}) =>
    GameState._internal(isStageCompleted: true,
                        loading: false,
                        backgroundUri: backgroundUri, 
                        liveStageBloc:liveStageBloc);

  GameState._internal({this.loading,
    this.backgroundUri,
    this.liveStageBloc,
    this.isStageCompleted,
    this.levelCompleted,
    this.isFinalLevel});

  /// Turns this state into one with the same information
  /// but flagging the specified level was completed.
  GameState completeLevel(int levelNumber, bool isLast) =>
      GameState._internal(loading: loading,
          backgroundUri: backgroundUri,
          liveStageBloc: liveStageBloc,
          levelCompleted: levelNumber,
          isFinalLevel: isLast,
          isStageCompleted: true);

  /// Whether we are loading a stage or not
  final bool loading;

  /// Whether the current stage has been completed
  final bool isStageCompleted;

  /// The number of level that was just completed
  /// or null if it hasn't been completed yet.
  final int levelCompleted;

  /// Is the, just completed, level the last
  final bool isFinalLevel;

  /// The background image uri
  final String backgroundUri;

  /// LiveStageBloc handling the current stage's current level.
  final LiveStageBloc liveStageBloc;
}
