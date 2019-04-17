import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

/// Event for GameSettingsBloc
/// Handles teh activation and deactivation of difficulties.
class GameSettingsEvent {

  GameSettingsEvent._internal({this.type, this.difficulty});

  /// Creates a GameSettingEvent for deactivating the specified difficulty.
  factory GameSettingsEvent.deactivate(GameModeDifficulty difficulty) =>
      GameSettingsEvent._internal(
          type: GameSettingsEventType.difficultyDeactivated,
          difficulty: difficulty
      );

  /// Creates a GameSettingEvent for activating the specified difficulty.
  factory GameSettingsEvent.activate(GameModeDifficulty difficulty) =>
    GameSettingsEvent._internal(
        type: GameSettingsEventType.difficultyActivated,
        difficulty: difficulty
    );

  /// Event type
  GameSettingsEventType type;
  /// Related GameModeDifficulty
  GameModeDifficulty difficulty;

}

/// GameSettingsEvent possible types
enum GameSettingsEventType {
  /// Activating a difficulty
  difficultyActivated,
  /// Deactivating a difficulty
  difficultyDeactivated
}
