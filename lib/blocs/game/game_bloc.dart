import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/model/live_level.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_factory.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  LiveLevel _liveLevel;
  Level _currentLevel;
  int _currentSentence;
  Repository repository;

  GameBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  GameState get initialState => InitialState();

  void startLevel() async {
    dispatch(StartLevel());
  }

  void failedAttempt(String content, int attempts) async {
    dispatch(FailedAttempt(content, attempts));
  }

  void pieceSuccess(String content) async {
    dispatch(PieceSuccess(content));
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
        _liveLevel = LiveLevel.updateProgressLevel(_liveLevel);
        if (_liveLevel.isSentenceComplete()) {
          yield await _renderSentenceCompleted();
        }
      }
    } catch (exception) {
      yield ErrorState(exception.toString());
    }
  }

  Future<GameState> _renderLevel() async {
    _currentLevel = await repository.getRandomLevel();
    _currentSentence = 0;
    _liveLevel = LiveLevel(sentence: _currentLevel.sentences[_currentSentence]);
    List<Piece> pieces = PieceFactory.getPieces(_liveLevel.sentence.concepts);
    return NextLevelState(pieces, _currentLevel.background);
  }

  GameState _renderFail(FailedAttempt event) {
    return FailContentState(event.content, event.attempts);
  }

  GameState _renderPieceSuccess(PieceSuccess event) {
    return WaitingForAnimationState(event.content);
  }

  Future<GameState> _renderSentenceCompleted() async {
    if (_currentSentence == _currentLevel.sentences.length - 1) {
      return _renderNextLevel();
    }

    return _renderNextSentence();
  }

  Future<GameState> _renderNextSentence() async {
    _currentSentence = _currentSentence + 1;
    _liveLevel = LiveLevel(sentence: _currentLevel.sentences[_currentSentence]);
    List<Piece> pieces = PieceFactory.getPieces(_liveLevel.sentence.concepts);
    // TODO make a new state
    return NextLevelState(pieces, _currentLevel.background);
  }

  Future<GameState> _renderNextLevel() async {
    // TODO render next level
    return _renderLevel();
  }
}
