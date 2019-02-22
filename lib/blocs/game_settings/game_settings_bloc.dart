import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game_settings/game_settings_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  Repository repository;

  GameSettingsBloc({this.repository}) {
    this.repository ??= Repository();
  }

  GameSettingsState get initialState => InitialState();

  Future<bool> setDifficulty(List<GameDifficulty> difficulties) async => repository.setShapeConfig(difficulties);

  @override
  Stream<GameSettingsState> mapEventToState(GameSettingsState state, GameSettingsEvent event) async* {
    try {} catch (exception) {
      yield ErrorState(exception.toString());
    }
  }
}
