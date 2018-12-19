import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';

class RandomFactory {
  static Word getRandomWord() {
    return Word(
      id: _getRandomId(),
      value: _getRandomText(),
      color: _getRandomColor(),
    );
  }

  static int _getRandomId() {
    return Random().nextInt(100000);
  }

  static Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.brown,
      Colors.purple,
      Colors.amberAccent,
      Colors.green,
      Colors.orange,
    ];
    colors.shuffle();
    return colors.removeLast();
  }

  static String _getRandomText() {
    final words = [
      'Cama',
      'Mesa',
      'Silla',
      'Yerba',
      'Vaso',
      'Pan',
      'Sol',
      'Sal',
      'Dado',
      'Mate',
    ];
    words.shuffle();
    return words.removeLast();
  }
}
