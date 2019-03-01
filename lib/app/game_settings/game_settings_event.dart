import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

abstract class GameSettingsEvent {}

class SetDifficulty extends GameSettingsEvent {
  final List<GameDifficulty> difficulties;

  SetDifficulty(this.difficulties);
}
