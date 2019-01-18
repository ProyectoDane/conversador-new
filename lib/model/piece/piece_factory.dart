import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class PieceFactory {
  static List<Piece> getPieces(List<Concept> concepts) {
    return concepts.map((concept) => _getPiece(concept)).toList();
  }

  static Piece _getPiece(Concept concept) => Piece(concept: concept);
}
