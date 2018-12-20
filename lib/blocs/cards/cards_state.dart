import 'package:flutter_cards/model/word.dart';

class CardsState {
  final List<Word> words;
  final String errorMessage;
  final bool waiting;

  CardsState({
    this.words = const [],
    this.errorMessage = "",
    this.waiting = false,
  });

  factory CardsState.initial() => CardsState();

  factory CardsState.error(String errorMessage) =>
      CardsState(errorMessage: errorMessage);

  factory CardsState.waitingForNextLevel() => CardsState(waiting: true);

  factory CardsState.nextLevel(List<Word> words) => CardsState(words: words);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardsState &&
          runtimeType == other.runtimeType &&
          words == other.words &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => words.hashCode ^ errorMessage.hashCode;
}
