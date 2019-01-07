import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/model/word.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static const int MAX_LEVEL = 3;
  Level _level = Level.initial();
  Repository repository;

  GameBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  GameState get initialState => InitialState();

  void startLevel() async {
    dispatch(StartLevel());
  }

  void failedAttempt(Word word, int attempts) async {
    dispatch(FailedAttempt(word, attempts));
  }

  void pieceSuccess(Word word) async {
    dispatch(PieceSuccess(word));
  }

  void animationCompleted() async {
    dispatch(AnimationCompleted());
  }

  @override
  Stream<GameState> mapEventToState(GameState state, GameEvent event) async* {
    try {
      if (event is StartLevel) {
        yield await _renderLevel();
      }

      if (event is FailedAttempt) {
        yield _renderFail(event);
      }

      if (event is PieceSuccess) {
        yield _renderPieceSuccess(event);
      }

      if (event is AnimationCompleted) {
        _level = Level.updateProgressLevel(_level);
        if (_level.isCompleted()) {
          yield await _renderLevelCompleted();
        }
      }
    } catch (exception) {
      yield ErrorState(exception.toString());
    }
  }

  Future<GameState> _renderLevel() async {
    final words = await repository.getWords(this._level.amountOfWords);
    return NextLevelState(words);
  }

  GameState _renderFail(FailedAttempt event) {
    return FailState(event.word, event.attempts);
  }

  GameState _renderPieceSuccess(PieceSuccess event) {
    return WaitingForAnimationState(event.word);
  }

  Future<GameState> _renderLevelCompleted() async {
    final hasToRestart = _level.value == MAX_LEVEL;
    return hasToRestart ? await _buildNextLevel(restart: true) : await _buildNextLevel();
  }

  Future<GameState> _buildNextLevel({bool restart = false}) async {
    _level = restart ? Level.initial() : Level.nextLevel(_level);
    return _renderLevel();
  }
}
