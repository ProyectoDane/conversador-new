abstract class GameEvent {}

class StartLevel extends GameEvent {}

class FailedAttempt extends GameEvent {
  final content;
  final attempts;

  FailedAttempt(this.content, this.attempts);
}

class PieceSuccess extends GameEvent {
  final content;

  PieceSuccess(this.content);
}

class AnimationCompleted extends GameEvent {}
