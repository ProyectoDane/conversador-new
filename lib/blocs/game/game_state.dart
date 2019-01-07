import 'package:flutter_syntactic_sorter/model/piece.dart';
import 'package:flutter_syntactic_sorter/model/word.dart';

abstract class GameState {}

class InitialState extends GameState {}

class NextLevelState extends GameState {
  final List<Piece> pieces;

  NextLevelState(this.pieces);
}

class FailState extends GameState {
  final Word word;
  final int attempts;

  FailState(this.word, this.attempts);
}

class WaitingForAnimationState extends GameState {
  final Word word;

  WaitingForAnimationState(this.word);
}

class WaitingForNextLevel extends GameState {}

class ErrorState extends GameState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
