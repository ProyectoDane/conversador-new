import 'package:flutter/material.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';

class PositionHelper {
  static List<double> generateEquidistantPositions(BuildContext context, int numberOfBoxes) {
    final width = MediaQuery.of(context).size.width;
    final distance = width / numberOfBoxes;

    final List<double> positions = [];
    for (int i = 0; i < numberOfBoxes; i++) {
      positions.add((distance * (i + 1 / 2)) - (Box.BOX_SIZE / 2));
    }
    positions.shuffle();
    return positions;
  }
}
