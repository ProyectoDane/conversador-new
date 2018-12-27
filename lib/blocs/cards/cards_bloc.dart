import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/level.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/repository/repository.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  Repository repository;
  Level level;

  CardsBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
    this.level = Level.initial();
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
        yield await _buildStartGame();
      }

      if (event is BoxSuccess) {
        level = Level.updateProgressLevel(level);
        if (level.isLevelCompleted()) {
          yield CardsState.waitingForNextLevel();
        }
      }

      if (event is LevelCompleted) {
        yield hasToRestart() ? await _buildNextLevel(restart: true) : await _buildNextLevel();
      }

      if (event is FailedAttempt) {
        yield CardsState.failedAttempt(event.word, event.attempts);
      }
    } catch (exception) {
      yield CardsState.error(exception.toString());
    }
  }

  Future<CardsState> _buildStartGame() async {
    final words = await repository.getWords(this.level.amountOfWords);
    return CardsState.nextLevel(words);
  }

  Future<CardsState> _buildNextLevel({bool restart = false}) async {
    level = restart ? Level.initial() : Level.nextLevel(level);
    final words = await repository.getWords(level.amountOfWords);
    return CardsState.nextLevel(words);
  }

  bool hasToRestart() {
    return level.value == 3;
  }
}
