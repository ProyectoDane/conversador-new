abstract class GameEvent {}

class StartLevel extends GameEvent {}

class FailedAttempt extends GameEvent {
  final concept;
  final attempts;

  FailedAttempt(this.concept, this.attempts);
}

class PieceSuccess extends GameEvent {
  final concept;

  PieceSuccess(this.concept);
}

class AnimationCompleted extends GameEvent {}
