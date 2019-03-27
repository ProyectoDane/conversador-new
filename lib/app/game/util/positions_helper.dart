import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class PositionHelper {
  
  static const double BORDER_PROPORTION = 0.1;
  
  static List<double> generateEquidistantXPositions(
    final BuildContext context,
    final int numberOfPieces,
  ) {
    final double width = MediaQuery.of(context).size.width;
    final double widthIncludingBorder = width * (1-BORDER_PROPORTION);
    final double blocks = widthIncludingBorder / numberOfPieces;

    final List<double> positions = <double>[];
    for (int i = 0; i < numberOfPieces; i++) {
      final double centerPositionInBlock = blocks * (i + 1 / 2)
          + width * BORDER_PROPORTION/2;
      final double centerShapeInBlock = centerPositionInBlock
          - Piece.BASE_SIZE / 2;
      positions.add(centerShapeInBlock);
    }

    return positions;
  }

  static double generateEquidistantYPosition(
      final BuildContext context,
      final bool shouldGoOnTop
  ) {
    final double height = MediaQuery.of(context).size.height;
    final double blocks = height / 2;
    final double baseOrHalf = shouldGoOnTop ? 0 : 1;
    final double centerPositionInBlock = blocks * (baseOrHalf + 1 / 2);
    return centerPositionInBlock - Piece.BASE_SIZE / 2;
  }
}
