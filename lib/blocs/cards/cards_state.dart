import 'package:flutter_cards/model/word.dart';

abstract class CardsState {}

class InitialState extends CardsState {}

class NextLevelState extends CardsState {
  final List<Word> words;

  NextLevelState(this.words);
}

class FailState extends CardsState {
  final Word word;
  final int attempts;

  FailState(this.word, this.attempts);
}

class WaitingForAnimationState extends CardsState {
  final Word word;

  WaitingForAnimationState(this.word);
}

class WaitingForNextLevel extends CardsState {}

class ErrorState extends CardsState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
