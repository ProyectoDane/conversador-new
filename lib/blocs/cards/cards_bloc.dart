import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/level.dart';
import 'package:flutter_cards/repository/repository.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  Repository repository;
  Level level;

  CardsBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
    this.level = Level(value: 1, amountOfSuccessful: 0, amountOfWords: 1);
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

  @override
  Stream<CardsState> mapEventToState(
      CardsState state, CardsEvent event) async* {
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
        yield await _buildNextLevel();
      }
    } catch (exception) {
      yield CardsState.error(exception.toString());
    }
  }

  Future<CardsState> _buildStartGame() async {
    final words = await repository.getWords(this.level.amountOfWords);
    return CardsState.nextLevel(words);
  }

  Future<CardsState> _buildNextLevel() async {
    level = Level.nextLevel(level);
    final words = await repository.getWords(level.amountOfWords);
    return CardsState.nextLevel(words);
  }
}
