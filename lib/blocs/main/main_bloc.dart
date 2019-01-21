import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_event.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  Repository repository;

  MainBloc({this.repository}) {
    this.repository ??= Repository();
  }

  MainState get initialState => InitialState();

  Future<bool> setDifficulty(List<GameDifficulty> difficulties) async => repository.setShapeConfig(difficulties);

  @override
  Stream<MainState> mapEventToState(MainState state, MainEvent event) async* {
    try {} catch (exception) {
      yield ErrorState(exception.toString());
    }
  }
}
