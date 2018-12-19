import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

class CardsState {
  final List<Word> words;
  final String errorMessage;

  CardsState({
    @required this.words,
    @required this.errorMessage,
  });

  factory CardsState.initial() => CardsState(words: [], errorMessage: "");

  factory CardsState.error(String errorMessage) => CardsState(words: [], errorMessage: errorMessage);

  factory CardsState.success(List<Word> words) => CardsState(words: words, errorMessage: "");

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
