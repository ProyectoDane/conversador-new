import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Class that can build the necessary widget for a certain piece.
class Figure {
  /// Creates a Figure based on a Decoration
  Figure({this.decoration});

  /// Decoration used for this figure
  final Decoration decoration;

  /// Builds a piece widget based on the piece type,
  /// the related concept content or value
  /// and the size it should have
  Widget buildWidget(
          {@required int pieceType,
          @required String content,
          @required double size}) =>
      Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(5),
        decoration: decoration,
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
      );
}
