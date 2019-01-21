import 'package:flutter_syntactic_sorter/model/concept/concept.dart';

abstract class GameEvent {}

class StartStage extends GameEvent {}

class FailedAttempt extends GameEvent {
  final Concept concept;
  final int attempts;

  FailedAttempt(this.concept, this.attempts);
}

class PieceSuccess extends GameEvent {
  final Concept concept;

  PieceSuccess(this.concept);
}

class AnimationCompleted extends GameEvent {}
