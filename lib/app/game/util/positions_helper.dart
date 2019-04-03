import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

/// Helper for calculating Piece's coordinates.
class PositionHelper {

  /// How much border (unused space) will we leave in proportion to the width
  static const double BORDER_PROPORTION = 0.1;

  /// Based on the quantity of pieces, the width available and a piece size,
  /// it calculates each piece's left border X coordinate.
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

  /// Based on the height available, a piece size and whether they should
  /// go on top of the screen or the bottom,
  /// it calculates each piece's top border Y coordinate.
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
