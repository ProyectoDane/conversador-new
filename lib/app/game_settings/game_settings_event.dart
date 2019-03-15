import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

class GameSettingsEvent {
  GameSettingsEventType type;
  GameDifficulty difficulty;

  GameSettingsEvent._internal(GameSettingsEventType type, GameDifficulty difficulty) {
    this.type = type;
    this.difficulty = difficulty;
  }

  factory GameSettingsEvent.deactivate(GameDifficulty difficulty) {
    return GameSettingsEvent._internal(GameSettingsEventType.difficultyDeactivated, difficulty);
  }

  factory GameSettingsEvent.activate(GameDifficulty difficulty) {
    return GameSettingsEvent._internal(GameSettingsEventType.difficultyActivated, difficulty);
  }
}

enum GameSettingsEventType {
  difficultyActivated,
  difficultyDeactivated
}
