import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class PositionHelper {
  static List<double> generateEquidistantPositions(BuildContext context, int numberOfPieces) {
    final width = MediaQuery.of(context).size.width;
    final distance = width / numberOfPieces;

    final List<double> positions = [];
    for (int i = 0; i < numberOfPieces; i++) {
      positions.add((distance * (i + 1 / 2)) - (Shape.BASE_SIZE / 2));
    }
    return positions;
  }
}
