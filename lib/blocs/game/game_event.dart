abstract class GameEvent {}

class StartLevel extends GameEvent {}

class FailedAttempt extends GameEvent {
  final word;
  final attempts;

  FailedAttempt(this.word, this.attempts);
}

class PieceSuccess extends GameEvent {
  final word;

  PieceSuccess(this.word);
}

class AnimationCompleted extends GameEvent {}
