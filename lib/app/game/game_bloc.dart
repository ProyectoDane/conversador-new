import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_factory.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  LiveStage _liveStage;
  Stage _currentStage;
  int _currentDifficulty;
  ShapeConfig _shapeConfig;
  Repository repository;
  LiveStageBloc liveStageBloc;

  GameBloc({this.repository}) {
    this.repository ??= Repository();
  }

  GameState get initialState => InitialState();

  void startStage() async {
    dispatch(StartStage());
  }

  @override
  Stream<GameState> mapEventToState(final GameState state, final GameEvent event) async* {
    try {
      if (event is StartStage) {
        yield await _renderStage();
      }
      if (event is LevelCompleted) {
        _liveStage = LiveStage.updateLevelProgress(_liveStage);
        liveStageBloc = LiveStageBloc(
          concepts: _liveStage.concepts,
          shapeConfig: _shapeConfig,
          onCompleted: () => dispatch(LevelCompleted()),
        );
        yield await _renderLevelCompleted();
      }
    } catch (exception) {
      yield ErrorState(exception.toString());
    }
  }

  Future<GameState> _renderStage() async {
    _currentStage = await repository.getRandomStage();
    _shapeConfig = await repository.getShapeConfig();
    _currentDifficulty = Stage.DIFFICULTY_EASY;
    return NextStageState(_getPieces(), _shapeConfig, _currentStage.backgroundUri);
  }

  List<Piece> _getPieces() {
    final concepts = Stage.getConceptsByDifficulty(_currentStage.sentence, _currentDifficulty);
    _liveStage = LiveStage(concepts: concepts);
    liveStageBloc = LiveStageBloc(
        concepts: concepts,
        shapeConfig: _shapeConfig,
        onCompleted: () => dispatch(LevelCompleted()),
    );
    return PieceFactory.getPieces(_liveStage.concepts);
  }

  Future<GameState> _renderLevelCompleted() async {
    return (_currentDifficulty == _currentStage.maxDifficulty) ? _renderNextStage() : _renderNextLevel();
  }

  Future<GameState> _renderNextLevel() async {
    _currentDifficulty = Stage.increaseDifficulty(_currentDifficulty);
    return NextLevelState(_getPieces(), _shapeConfig, _currentStage.backgroundUri);
  }

  // TODO do something to increase stage
  Future<GameState> _renderNextStage() async => _renderStage();
}
