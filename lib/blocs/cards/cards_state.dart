import 'package:flutter_cards/model/word.dart';

class CardsState {
  // TODO is it too big?
  final List<Word> words;
  final String errorMessage;
  final bool waiting;
  final int attempts;
  final Word word;

  CardsState({
    this.words = const [],
    this.errorMessage = "",
    this.waiting = false,
    this.attempts = 0,
    this.word,
  });

  factory CardsState.initial() => CardsState();

  factory CardsState.error(String errorMessage) => CardsState(errorMessage: errorMessage);

  factory CardsState.waitingForNextLevel() => CardsState(waiting: true);

  factory CardsState.nextLevel(List<Word> words) => CardsState(words: words);

  factory CardsState.failedAttempt(Word word, int attempts) => CardsState(word: word, attempts: attempts);

  bool isError() => this.errorMessage.isNotEmpty;

  bool isNextLevel() => this.words.isNotEmpty;

  bool isWaitingForNextLevel() => this.waiting;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardsState &&
          runtimeType == other.runtimeType &&
          words == other.words &&
          errorMessage == other.errorMessage &&
          attempts == other.attempts &&
          word == other.word;

  @override
  int get hashCode => words.hashCode ^ errorMessage.hashCode ^ attempts.hashCode ^ word.hashCode;
}
