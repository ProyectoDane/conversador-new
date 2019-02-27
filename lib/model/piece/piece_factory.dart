import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class PieceFactory {
  static List<Piece> getPieces(final List<Concept> concepts) {
    return concepts.map((concept) => Piece(concept: concept)).toList();
  }
}
