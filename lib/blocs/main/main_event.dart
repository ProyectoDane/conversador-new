import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';

abstract class MainEvent {}

class SetDifficulty extends MainEvent {
  final List<GameDifficulty> difficulties;

  SetDifficulty(this.difficulties);
}
