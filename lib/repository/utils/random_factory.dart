import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';

class RandomFactory {
  static List<Word> getRandomWords(int amount) {
    final List<Word> words = [];
    for (int i = 0; i < amount; i++) {
      words.add(_getRandomWord());
    }
    return words;
  }

  static Word _getRandomWord() {
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

  static List<double> generateXPositions(BuildContext context, int numberOfBoxes) {
    final width = MediaQuery.of(context).size.width;
    final distance = width / numberOfBoxes;

    final List<double> results = [];
    for (int i = 0; i < numberOfBoxes; i++) {
      results.add((distance * (i + 1 / 2)) - Box.BOX_SIZE / 2);
    }
    results.shuffle();
    return results;
  }
}
