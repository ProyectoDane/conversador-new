import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Class that can build the necessary widget for a certain piece.
class Figure {
  /// Creates a Figure based on a painter
  Figure({this.painter});

  /// Decoration used for this figure
  final CustomPainter painter;

  /// Builds a piece widget based on the piece type,
  /// the related concept content or value
  /// and the size it should have
  Widget buildWidget(
          {@required int pieceType,
          @required String content,
          @required double size}) =>
      CustomPaint(
        size: Size(size, size),
        painter: painter,
        child: Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: Dimen.FONT_SMALL),
            ),
          ),
        ),
      );
}
