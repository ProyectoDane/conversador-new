import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_event.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/repository/repository.dart';
import 'package:tuple/tuple.dart';

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  Repository repository;

  GameSettingsBloc({this.repository}) {
    this.repository ??= Repository();
  }

  GameSettingsState get initialState => GameSettingsState([
    Tuple2(ShapeDifficulty(), false),
    Tuple2(ColorDifficulty(), false),
  ]);

  Future<bool> saveDifficulties() async => repository.setShapeConfig(currentState.difficulties.where((tuple) => tuple.item2).map((tuple) => tuple.item1).toList());
  
  void tappedOnDifficulty(GameDifficulty difficulty) {
    final tuple = currentState.difficulties.firstWhere((tuple) => tuple.item1 == difficulty);
    if (tuple.item2) {
      dispatch(GameSettingsEvent.deactivate(difficulty));
    } else {
      dispatch(GameSettingsEvent.activate(difficulty));
    }
  }
  
  @override
  Stream<GameSettingsState> mapEventToState(final GameSettingsState state, final GameSettingsEvent event) async* {
    switch (event.type) {
      case GameSettingsEventType.difficultyActivated:
        yield state.activate(event.difficulty);
        break;
      case GameSettingsEventType.difficultyDeactivated:
        yield state.deactivate(event.difficulty);
        break;
    }
  }
}
