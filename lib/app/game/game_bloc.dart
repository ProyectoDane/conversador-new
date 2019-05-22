import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/level_repository.dart';
import 'package:flutter_syntactic_sorter/repository/piece_config_repository.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';
import 'package:flutter_syntactic_sorter/app/game/util/tts_manager.dart';

/// Bloc for Game part of the app.
/// It takes care of selecting a stage and moving through its
/// levels and then on to another stage.
class GameBloc extends Bloc<GameEvent, GameState> {
  /// Creates a GameBloc that uses the repositories
  /// to get the stages and the configured piece configuration.
  /// There are default values for both repositories.
  GameBloc(
      {PieceConfigRepository pieceConfigRepository,
      LevelRepository levelRepository}) {
    _pieceConfigRepository = pieceConfigRepository ?? PieceConfigRepository();
    _levelRepository = levelRepository ?? LevelRepository(StageRepository());
  }

  PieceConfigRepository _pieceConfigRepository;
  LevelRepository _levelRepository;

  Level _currentLevel;
  int _currentStageIndex;
  LiveStage _currentLiveStage;
  PieceConfig _pieceConfig;

  Stage get _currentStage => _currentLevel.stages[_currentStageIndex];

  // MARK: - Events
  /// The view was shown for the first time.
  void viewWasShown() {
    dispatch(StartStage((GameState oldState) async* {
      _pieceConfig = await _pieceConfigRepository.getPieceConfig();
      yield await _getFirstStage();
    }));
  }

  /// Called when the current live stage was completed
  void liveStageWasFinished() {
    dispatch(LiveStageCompleted((GameState oldState) async* {
      yield await _getNext(oldState);
    }));
  }

  /// Called when the user decides to continue to the next level
  void continueToNextLevel() {
    dispatch(LevelCompleted((GameState oldState) async* {
      yield GameState.loading();
      yield await _getNextLevel(oldState);
    }));
  }

  // MARK: - State
  @override
  GameState get initialState => GameState.loading();

  @override
  Stream<GameState> mapEventToState(
      final GameState currentState, final GameEvent event) async* {
    yield* event.mutateState(currentState);
  }

  Future<GameState> _getFirstStage() async {
    final Level level = await _levelRepository.getFirstLevel();
    _currentLevel = level;
    _currentStageIndex = -1;
    return _getNewStage(null);
  }

  Future<GameState> _getNextLevel(GameState oldState) async {
    _currentLevel =
        await _levelRepository.getLevel(_currentLevel.id + 1);
    _currentLevel ??= await _levelRepository.getFirstLevel();
    _currentStageIndex = -1;
    return _getNewStage(oldState);
  }

  Future<GameState> _getNewStage(GameState oldState) async {
    if (_currentStageIndex == _currentLevel.stages.length - 1) {
      return oldState.completeLevel(_currentLevel.id);
    }
    _currentStageIndex++;
    _currentLiveStage = _currentStage.getInitialLiveStage();
    final LiveStageBloc liveStageBloc =
        _getLiveStageBlocFrom(_currentLiveStage);
    return GameState.stage(
        backgroundUri: _currentStage.backgroundUri,
        liveStageBloc: liveStageBloc);
  }

  Future<GameState> _getNext(GameState state) async {
    final LiveStage nextLiveStage =
        _currentStage.getFollowingLiveStage(_currentLiveStage.depth);
    if (nextLiveStage == null) {
      // Reproduces sentence audio
      final Duration duration = await TtsManager().playSentence(
        _currentStage.sentence);
      // Delays the stage change according to sentence audio
      await Future<GameState>.delayed(duration, (){});
      // Enters new stage
      return _getNewStage(state);
    } else {
      _currentLiveStage = nextLiveStage;
      final LiveStageBloc liveStageBloc = _getLiveStageBlocFrom(nextLiveStage);
      return GameState.stage(
          backgroundUri: _currentStage.backgroundUri,
          liveStageBloc: liveStageBloc);
    }
  }

  LiveStageBloc _getLiveStageBlocFrom(LiveStage liveStage) => LiveStageBloc(
        subjectConcepts: liveStage.subjectConcepts,
        predicateConcepts: liveStage.predicateConcepts,
        pieceConfig: _pieceConfig,
        onCompleted: liveStageWasFinished,
      );
}
