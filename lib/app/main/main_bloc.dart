import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/main/main_event.dart';
import 'package:flutter_syntactic_sorter/app/main/main_state.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  Repository repository;

  MainState get initialState => InitialState();

  @override
  Stream<MainState> mapEventToState(final MainState state, final MainEvent event) async* {
    try {} catch (exception) {
      yield ErrorState(exception.toString());
    }
  }
}
