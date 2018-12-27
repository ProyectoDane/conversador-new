abstract class CardsEvent {}

class StartGame extends CardsEvent {}

class BoxSuccess extends CardsEvent {}

class LevelCompleted extends CardsEvent {}

class FailedAttempt extends CardsEvent {
  final word;
  final attempts;

  FailedAttempt(this.word, this.attempts);
}
