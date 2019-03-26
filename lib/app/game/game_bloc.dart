import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Stage _currentStage;
  int _currentDifficulty;
  PieceConfig _pieceConfig;
  Repository repository;

  GameBloc({this.repository}) {
    this.repository ??= Repository();
  }

  GameState get initialState => GameState.loading();

  void viewWasShown() async {
    dispatch(StartStage());
  }

  @override
  Stream<GameState> mapEventToState(final GameState state, final GameEvent event) async* {
    if (event is StartStage) {
      _pieceConfig = await repository.getPieceConfig();
      yield await _getNewStage();
    }
    if (event is LiveStageCompleted) {
      yield await _getNext(state);
    }
  }

  Future<GameState> _getNewStage() async {
    final stage = await repository.getRandomStage();
    _currentDifficulty = Stage.DIFFICULTY_EASY;
    _currentStage = stage;
    final liveStage = _currentStage.getLiveStageForDifficulty(_currentDifficulty);
    final liveStageBloc = LiveStageBloc(
      subjectConcepts: liveStage.subjectConcepts,
      predicateConcepts: liveStage.predicateConcepts,
      pieceConfig: _pieceConfig,
      onCompleted: () => dispatch(LiveStageCompleted()),
    );
    return GameState(false, stage.backgroundUri, liveStageBloc);
  }

  Future<GameState> _getNext(GameState state) async {
    final nextLiveStage = _currentStage.getFollowingLiveStage(_currentDifficulty);
    if (nextLiveStage == null) {
      return _getNewStage();
    } else {
      _currentDifficulty = nextLiveStage.difficulty;
      final liveStageBloc = LiveStageBloc(
        subjectConcepts: nextLiveStage.subjectConcepts,
        predicateConcepts: nextLiveStage.predicateConcepts,
        pieceConfig: _pieceConfig,
        onCompleted: () => dispatch(LiveStageCompleted()),
      );
      return GameState(false, _currentStage.backgroundUri, liveStageBloc);
    }
  }

}
