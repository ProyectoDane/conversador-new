import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_stage_selection_helper.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/level_repository.dart';
import 'package:flutter_syntactic_sorter/repository/piece_config_repository.dart';
import 'package:flutter_syntactic_sorter/repository/stage_repository.dart';
import 'package:flutter_syntactic_sorter/app/game/util/tts_manager.dart';
import 'package:tuple/tuple.dart';
import 'package:pedantic/pedantic.dart';

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

  /// Called when the user decides to continue to the next stage 
  /// with a new phrase
  void continueToNextStage() {
    dispatch(LoadNextStage((GameState oldState) async* {
      yield await _getNewStage(oldState);
    }));
  }
  
  /// Called when the user decides to continue to the next level
  void continueToNextLevel() {
    dispatch(LevelCompleted((GameState oldState) async* {
      yield GameState.loading();
      yield await _getNextLevel(oldState);
    }));
  }

  /// Replays phrase by text to speech
  void replayPhraseSound() {
    TtsManager().playSentence(_currentStage.sentence);
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
    final int preselectedStage = 
      StageSelection().stageSelection ?? StageSelection().lastStagePlayed;

    if (preselectedStage != null) {
      final int id = preselectedStage;
      final Tuple2<Level, int> levelData = 
        await _levelRepository.getLevelWithStageId(id);
      _currentLevel = levelData.item1;
      _currentStageIndex = levelData.item2 - 1;
    } else {
      _currentLevel = await _levelRepository.getFirstLevel();
      _currentStageIndex = -1;
    }

    return _getNewStage(null);
  }

  Future<GameState> _getStageCompleteState(GameState oldState) async {
    final LiveStageBloc liveStageBloc =
        _getLiveStageBlocFrom(_currentLiveStage, true);
    return GameState.stageComplete(
      backgroundUri:_currentStage.backgroundUri,
      liveStageBloc: liveStageBloc);
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
      final bool isFinalLevel = 
        await _levelRepository.isFinalLevel(_currentLevel.id);
      return oldState.completeLevel(
        _currentLevel.id, isFinalLevel);
    }
    _currentStageIndex++;
    _currentLiveStage = _currentStage.getInitialLiveStage();

    StageSelection().lastStagePlayed = _currentStage.id;

    final LiveStageBloc liveStageBloc =
        _getLiveStageBlocFrom(_currentLiveStage, false);
    return GameState.stage(
        backgroundUri: _currentStage.backgroundUri,
        liveStageBloc: liveStageBloc);
  }

  Future<GameState> _getNext(GameState state) async {
    final LiveStage nextLiveStage =
        _currentStage.getFollowingLiveStage(_currentLiveStage.depth);
    if (nextLiveStage == null) {
      // Reproduces sentence audio
      unawaited(TtsManager().playSentence(
        _currentStage.sentence));
      // Shows stage complete UI
      return _getStageCompleteState(state);
    } else {
      _currentLiveStage = nextLiveStage;
      final LiveStageBloc liveStageBloc = 
        _getLiveStageBlocFrom(nextLiveStage, false);
      return GameState.stage(
          backgroundUri: _currentStage.backgroundUri,
          liveStageBloc: liveStageBloc);
    }
  }

  LiveStageBloc _getLiveStageBlocFrom(
    LiveStage liveStage, bool isStageCompleted) => LiveStageBloc(
      subjectConcepts: liveStage.subjectConcepts,
      predicateConcepts: liveStage.predicateConcepts,
      pieceConfig: _pieceConfig,
      onCompleted: liveStageWasFinished,
      isShuffled: !isStageCompleted
    );
}
