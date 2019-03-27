import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/piece_config_repository.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  /// Creates a GameBloc that uses the repositories
  /// to get the stages and the configured piece configuration.
  GameBloc({
    PieceConfigRepository pieceConfigRepository,
    StageRepository stageRepository
  }) :
    _pieceConfigRepository = pieceConfigRepository ?? PieceConfigRepository(),
    _stageRepository = stageRepository ?? StageRepository();


  Stage _currentStage;
  int _currentDifficulty;
  PieceConfig _pieceConfig;
  final PieceConfigRepository _pieceConfigRepository;
  final StageRepository _stageRepository;

  @override
  GameState get initialState => GameState.loading();

  void viewWasShown() {
    dispatch(StartStage((GameState oldState) async* {
      _pieceConfig = await _pieceConfigRepository.getPieceConfig();
      yield await _getNewStage();
    }));
  }

  void liveStageWasFinished() {
    dispatch(LiveStageCompleted((GameState oldState) async* {
      yield await _getNext(oldState);
    }));
  }

  @override
  Stream<GameState> mapEventToState(
      final GameState currentState,
      final GameEvent event
  ) async* {
    yield* event.mutateState(currentState);
  }

  Future<GameState> _getNewStage() async {
    final Stage stage = await _stageRepository.getRandomStage();
    _currentDifficulty = Stage.DIFFICULTY_EASY;
    _currentStage = stage;
    final LiveStage liveStage =
      _currentStage.getLiveStageForDifficulty(_currentDifficulty);
    final LiveStageBloc liveStageBloc = LiveStageBloc(
      subjectConcepts: liveStage.subjectConcepts,
      predicateConcepts: liveStage.predicateConcepts,
      pieceConfig: _pieceConfig,
      onCompleted: liveStageWasFinished,
    );
    return GameState(
        loading: false,
        backgroundUri: stage.backgroundUri,
        liveStageBloc: liveStageBloc);
  }

  Future<GameState> _getNext(GameState state) async {
    final LiveStage nextLiveStage =
      _currentStage.getFollowingLiveStage(_currentDifficulty);
    if (nextLiveStage == null) {
      return _getNewStage();
    } else {
      _currentDifficulty = nextLiveStage.difficulty;
      final LiveStageBloc liveStageBloc = LiveStageBloc(
        subjectConcepts: nextLiveStage.subjectConcepts,
        predicateConcepts: nextLiveStage.predicateConcepts,
        pieceConfig: _pieceConfig,
        onCompleted: liveStageWasFinished,
      );
      return GameState(
          loading: false,
          backgroundUri: _currentStage.backgroundUri,
          liveStageBloc: liveStageBloc);
    }
  }

}
