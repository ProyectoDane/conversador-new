import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape.dart';
import 'package:flutter_syntactic_sorter/model/word.dart';

class PieceFactory {
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
      shape: _getRandomShape(),
    );
  }

  static int _getRandomId() {
    return Random().nextInt(100000);
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

  static Shape _getRandomShape() {
    return Shape(
      id: _getRandomId(),
      color: _getRandomColor(),
      type: _getRandomType(),
    );
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

  static int _getRandomType() {
    final shapes = List.from(Shape.SHAPES);
    shapes.shuffle();
    return shapes.removeLast();
  }
}
