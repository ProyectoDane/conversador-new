import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class PieceFactory {
  static List<Piece> getPieces(final List<Concept> concepts) {
    List<Piece> pieces = List();
    for (var i = 0; i < concepts.length; i++) {
      pieces.add(Piece(concept: concepts[i], index: i));
    }
    return pieces;
  }
}
