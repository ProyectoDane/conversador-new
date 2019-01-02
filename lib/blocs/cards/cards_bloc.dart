import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/level.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/repository/repository.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  Repository repository;
  Level _level = Level.initial();

  CardsBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  CardsState get initialState => CardsState.initial();

  void loadWords() async {
    dispatch(StartGame());
  }

  void boxSuccess() async {
    dispatch(BoxSuccess());
  }

  void levelCompleted() async {
    dispatch(LevelCompleted());
  }

  void failedAttempt(Word word, int attempts) async {
    dispatch(FailedAttempt(word, attempts));
  }

  @override
  Stream<CardsState> mapEventToState(CardsState state, CardsEvent event) async* {
    try {
      if (event is StartGame) {
        yield await _buildLevel();
      }

      if (event is BoxSuccess) {
        _level = Level.updateProgressLevel(_level);
        if (_level.isLevelCompleted()) {
          yield CardsState.waitingForNextLevel();
        }
      }

      if (event is LevelCompleted) {
        yield _hasToRestart() ? await _buildNextLevel(restart: true) : await _buildNextLevel();
      }

      if (event is FailedAttempt) {
        yield CardsState.failedAttempt(event.word, event.attempts);
      }
    } catch (exception) {
      yield CardsState.error(exception.toString());
    }
  }

  Future<CardsState> _buildLevel() async {
    final words = await repository.getWords(this._level.amountOfWords);
    return CardsState.nextLevel(words);
  }

  bool _hasToRestart() {
    return _level.value == 3;
  }

  Future<CardsState> _buildNextLevel({bool restart = false}) async {
    _level = restart ? Level.initial() : Level.nextLevel(_level);
    return _buildLevel();
  }
}
