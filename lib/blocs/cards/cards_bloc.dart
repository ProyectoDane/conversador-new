import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/repository/repository.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  var repository;

  CardsBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  CardsState get initialState => CardsState.initial();

  @override
  Stream<CardsState> mapEventToState(CardsState state, CardsEvent event) async* {}
}
