import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/piece_config_repository.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Stage _currentStage;
  int _currentDifficulty;
  PieceConfig _pieceConfig;
  PieceConfigRepository pieceConfigRepository;
  StageRepository stageRepository;

  GameBloc({this.pieceConfigRepository, this.stageRepository}) {
    this.pieceConfigRepository ??= PieceConfigRepository();
    this.stageRepository ??= StageRepository();
  }

  GameState get initialState => GameState.loading();

  void viewWasShown() async {
    dispatch(StartStage());
  }

  @override
  Stream<GameState> mapEventToState(final GameState state, final GameEvent event) async* {
    if (event is StartStage) {
      _pieceConfig = await pieceConfigRepository.getPieceConfig();
      yield await _getNewStage();
    }
    if (event is LiveStageCompleted) {
      yield await _getNext(state);
    }
  }

  Future<GameState> _getNewStage() async {
    final stage = await stageRepository.getRandomStage();
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
