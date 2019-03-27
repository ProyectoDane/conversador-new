import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

class GameSettingsEvent {

  GameSettingsEvent._internal({this.type, this.difficulty});

  factory GameSettingsEvent.deactivate(GameDifficulty difficulty) =>
      GameSettingsEvent._internal(
          type: GameSettingsEventType.difficultyDeactivated,
          difficulty: difficulty
      );

  factory GameSettingsEvent.activate(GameDifficulty difficulty) =>
    GameSettingsEvent._internal(
        type: GameSettingsEventType.difficultyActivated,
        difficulty: difficulty
    );


  GameSettingsEventType type;
  GameDifficulty difficulty;

}

enum GameSettingsEventType {
  difficultyActivated,
  difficultyDeactivated
}
