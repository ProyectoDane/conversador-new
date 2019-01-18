import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

abstract class GameState {}

class InitialState extends GameState {}

class NextStageState extends GameState {
  final List<Piece> pieces;
  final ShapeConfig shapeConfig;
  final String backgroundUri;

  NextStageState(this.pieces, this.shapeConfig, this.backgroundUri);
}

class NextLevelState extends GameState {
  final List<Piece> pieces;
  final ShapeConfig shapeConfig;
  final String backgroundUri;

  NextLevelState(this.pieces, this.shapeConfig, this.backgroundUri);
}

// TODO maybe use concept
class FailContentState extends GameState {
  final String content;
  final int attempts;

  FailContentState(this.content, this.attempts);
}

// TODO maybe use concept
class WaitingForAnimationState extends GameState {
  final String content;

  WaitingForAnimationState(this.content);
}

class ErrorState extends GameState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
