import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

abstract class GameState {}

class InitialState extends GameState {}

class NextStageState extends GameState {
  final List<Piece> pieces;
  final String backgroundUri;

  NextStageState(this.pieces, this.backgroundUri);
}

class NextLevelState extends GameState {
  final List<Piece> pieces;
  final String backgroundUri;

  NextLevelState(this.pieces, this.backgroundUri);
}

class FailContentState extends GameState {
  final String content;
  final int attempts;

  FailContentState(this.content, this.attempts);
}

class WaitingForAnimationState extends GameState {
  final String content;

  WaitingForAnimationState(this.content);
}

class ErrorState extends GameState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
