import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

abstract class GameState {}

class InitialState extends GameState {}

class NextLevelState extends GameState {
  final List<Piece> pieces;

  NextLevelState(this.pieces);
}

class FailConceptState extends GameState {
  final String concept;
  final int attempts;

  FailConceptState(this.concept, this.attempts);
}

class WaitingForAnimationState extends GameState {
  final String concept;

  WaitingForAnimationState(this.concept);
}

class ErrorState extends GameState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
