import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/word.dart';

class PieceFactory {
  static List<Piece> getRandomPieces(int amount) {
    final List<Piece> pieces = [];
    for (int i = 0; i < amount; i++) {
      pieces.add(_getRandomPiece());
    }
    return pieces;
  }

  static Piece _getRandomPiece() {
    return Piece(
      word: _getRandomWord(),
      shape: _getRandomShape(),
    );
  }

  static Word _getRandomWord() {
    return Word(
      id: _getRandomId(),
      value: _getRandomText(),
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
    final type = _getRandomType();
    switch (type) {
      case Rectangle.TYPE:
        return Rectangle(
          id: _getRandomId(),
          color: _getRandomColor(),
        );
      case Circle.TYPE:
      default:
        return Circle(
          id: _getRandomId(),
          color: _getRandomColor(),
        );
    }
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
    final shapes = [Rectangle.TYPE, Circle.TYPE];
    shapes.shuffle();
    return shapes.removeLast();
  }
}
