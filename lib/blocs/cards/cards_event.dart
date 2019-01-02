abstract class CardsEvent {}

class StartLevel extends CardsEvent {}

class FailedAttempt extends CardsEvent {
  final word;
  final attempts;

  FailedAttempt(this.word, this.attempts);
}

class BoxSuccess extends CardsEvent {
  final word;

  BoxSuccess(this.word);
}

class AnimationCompleted extends CardsEvent {}

class LevelCompleted extends CardsEvent {}
