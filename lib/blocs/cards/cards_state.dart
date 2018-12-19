import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

class CardsState {
  final word;
  final errorMessage;

  CardsState({
    @required this.word,
    @required this.errorMessage,
  });

  factory CardsState.initial() => CardsState(word: null, errorMessage: null);

  factory CardsState.error(String errorMessage) => CardsState(word: null, errorMessage: errorMessage);

  factory CardsState.success(Word word) => CardsState(word: word, errorMessage: null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardsState &&
          runtimeType == other.runtimeType &&
          word == other.word &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => word.hashCode ^ errorMessage.hashCode;
}
