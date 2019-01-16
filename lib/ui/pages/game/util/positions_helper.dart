import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class PositionHelper {
  static List<double> generateEquidistantPositions(BuildContext context, bool isDrag, int numberOfPieces) {
    final width = MediaQuery.of(context).size.width;
    final distance = width / numberOfPieces;

    final List<double> positions = [];
    for (int i = 0; i < numberOfPieces; i++) {
      positions.add((distance * (i + 1 / 2)) - (Shape.BASE_SIZE / 2));
    }

    if (isDrag) {
      positions.shuffle();
    }

    return positions;
  }

  static double generateYPosition(BuildContext context, bool isDrag) {
    final height = MediaQuery.of(context).size.height;
    final distance = height / 2;
    final coefficient = isDrag ? 0 : 1;
    return (distance * (coefficient + 1 / 2)) - (Shape.BASE_SIZE / 2);
  }
}
