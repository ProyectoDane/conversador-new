import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

class GameSettingsEvent {
  GameSettingsEventType type;
  GameDifficulty difficulty;

  GameSettingsEvent(this.type, this.difficulty);

  factory GameSettingsEvent.deactivate(GameDifficulty difficulty) {
    return GameSettingsEvent(GameSettingsEventType.difficultyDeactivated, difficulty);
  }

  factory GameSettingsEvent.activate(GameDifficulty difficulty) {
    return GameSettingsEvent(GameSettingsEventType.difficultyActivated, difficulty);
  }
}

enum GameSettingsEventType {
  difficultyActivated,
  difficultyDeactivated
}
