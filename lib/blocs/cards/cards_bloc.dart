import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/level.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/repository/repository.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  static const int MAX_LEVEL = 3;
  Level _level = Level.initial();
  Repository repository;

  CardsBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  CardsState get initialState => InitialState();

  void startLevel() async {
    dispatch(StartLevel());
  }

  void failedAttempt(Word word, int attempts) async {
    dispatch(FailedAttempt(word, attempts));
  }

  void boxSuccess(Word word) async {
    dispatch(BoxSuccess(word));
  }

  void animationCompleted() async {
    dispatch(AnimationCompleted());
  }

  void levelCompleted() async {
    dispatch(LevelCompleted());
  }

  @override
  Stream<CardsState> mapEventToState(CardsState state, CardsEvent event) async* {
    try {
      if (event is StartLevel) {
        yield await _renderLevel();
      }

      if (event is FailedAttempt) {
        yield _renderFail(event);
      }

      if (event is BoxSuccess) {
        yield _renderBoxSuccess(event);
      }

      if (event is AnimationCompleted) {
        if (_level.isLevelCompleted()) {
          yield await _renderLevelCompleted();
        }
      }

      if (event is LevelCompleted) {
        yield await _renderLevelCompleted();
      }
    } catch (exception) {
      yield ErrorState(exception.toString());
    }
  }

  Future<CardsState> _renderLevel() async {
    final words = await repository.getWords(this._level.amountOfWords);
    return NextLevelState(words);
  }

  CardsState _renderFail(FailedAttempt event) {
    return FailState(event.word, event.attempts);
  }

  CardsState _renderBoxSuccess(BoxSuccess event) {
    _level = Level.updateProgressLevel(_level);
    return WaitingForAnimationState(event.word);
  }

  Future<CardsState> _renderLevelCompleted() async {
    return _hasToRestart() ? await _buildNextLevel(restart: true) : await _buildNextLevel();
  }

  bool _hasToRestart() {
    return _level.value == MAX_LEVEL;
  }

  Future<CardsState> _buildNextLevel({bool restart = false}) async {
    _level = restart ? Level.initial() : Level.nextLevel(_level);
    return _renderLevel();
  }
}
