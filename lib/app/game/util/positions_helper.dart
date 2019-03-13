import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class PositionHelper {
  
  static const BORDER_PROPORTION = 0.1;
  
  static List<double> generateEquidistantXPositions(
    final BuildContext context,
    final int numberOfPieces,
  ) {
    final width = MediaQuery.of(context).size.width;
    final widthIncludingBorder = width * (1-BORDER_PROPORTION);
    final blocks = widthIncludingBorder / numberOfPieces;

    final List<double> positions = [];
    for (int i = 0; i < numberOfPieces; i++) {
      final centerPositionInBlock = blocks * (i + 1 / 2) + width * BORDER_PROPORTION/2;
      final centerShapeInBlock = centerPositionInBlock - Piece.BASE_SIZE / 2;
      positions.add(centerShapeInBlock);
    }

    return positions;
  }

  static double generateEquidistantYPosition(final BuildContext context, final bool shouldGoOnTop) {
    final height = MediaQuery.of(context).size.height;
    final blocks = height / 2;
    final baseOrHalf = shouldGoOnTop ? 0 : 1;
    final centerPositionInBlock = blocks * (baseOrHalf + 1 / 2);
    return centerPositionInBlock - Piece.BASE_SIZE / 2;
  }
}
