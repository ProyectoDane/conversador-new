abstract class CardsEvent {}

class LoadWords extends CardsEvent {
  final level;
  LoadWords(this.level);
}