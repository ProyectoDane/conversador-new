import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/src/model_exports.dart';

/// Event for GameSettingsBloc
/// Handles the activation and deactivation of difficulties.
class GameSettingsEvent {

  GameSettingsEvent._internal(
    {this.type, this.difficulty, this.stages, this.isStageListVisible});

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

  /// Creates a GameSettingEvent for updating stage list
  factory GameSettingsEvent.updatedStages(List<Stage> stages) => 
    GameSettingsEvent._internal(
      type: GameSettingsEventType.stagesUpdated, 
      stages: stages);

  /// Creates a GameSettingEvent for showing/hiding stageList
  factory GameSettingsEvent.toggledStageList() => 
    GameSettingsEvent._internal(
      type: GameSettingsEventType.stageVisibilityToggled);

  /// Event type
  GameSettingsEventType type;
  /// Related GameModeDifficulty
  GameModeDifficulty difficulty;
  /// Related stages list
  List<Stage> stages;
  /// Whether or not stage list is visible
  bool isStageListVisible;
}

/// GameSettingsEvent possible types
enum GameSettingsEventType {
  /// Activating a difficulty
  difficultyActivated,
  /// Deactivating a difficulty
  difficultyDeactivated,
  /// Updating the stage list
  stagesUpdated,
  /// Changing stage list visibility
  stageVisibilityToggled
}
