import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_factory.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  LiveStage _liveStage;
  Stage _currentStage;
  int _currentLevel;
  ShapeConfig _shapeConfig;
  Repository repository;

  GameBloc({this.repository}) {
    this.repository ??= Repository();
  }

  GameState get initialState => InitialState();

  void startStage() async {
    dispatch(StartStage());
  }

  void failedAttempt(Concept concept, int attempts) async {
    dispatch(FailedAttempt(concept, attempts));
  }

  void pieceSuccess(Concept concept) async {
    dispatch(PieceSuccess(concept));
  }

  void animationCompleted() async {
    dispatch(AnimationCompleted());
  }

  @override
  Stream<GameState> mapEventToState(GameState state, GameEvent event) async* {
    try {
      if (event is StartStage) {
        yield await _renderStage();
      }

      if (event is FailedAttempt) {
        yield _renderFail(event);
      }

      if (event is PieceSuccess) {
        yield _renderPieceSuccess(event);
      }

      if (event is AnimationCompleted) {
        _liveStage = LiveStage.updateLevelProgress(_liveStage);
        if (_liveStage.isLevelComplete()) {
          yield await _renderLevelCompleted();
        }
      }
    } catch (exception) {
      yield ErrorState(exception.toString());
    }
  }

  Future<GameState> _renderStage() async {
    _currentStage = await repository.getRandomStage();
    _shapeConfig = await repository.getShapeConfig();
    _currentLevel = 0;
    final pieces = _getPieces();
    return NextStageState(pieces, _shapeConfig, _currentStage.backgroundUri);
  }

  List<Piece> _getPieces() {
    final level = _currentStage.levels[_currentLevel];
    _liveStage = LiveStage(level: level);
    final concepts = _liveStage.level.concepts;
    return PieceFactory.getPieces(concepts);
  }

  GameState _renderFail(FailedAttempt event) => FailContentState(event.concept, event.attempts);

  GameState _renderPieceSuccess(PieceSuccess event) => WaitingForAnimationState(event.concept);

  Future<GameState> _renderLevelCompleted() async {
    return (_currentLevel == _currentStage.levels.length - 1) ? _renderNextStage() : _renderNextLevel();
  }

  Future<GameState> _renderNextLevel() async {
    _currentLevel = _currentLevel + 1;
    final pieces = _getPieces();
    return NextLevelState(pieces, _shapeConfig, _currentStage.backgroundUri);
  }

  // TODO do something to increase stage
  Future<GameState> _renderNextStage() async => _renderStage();
}
