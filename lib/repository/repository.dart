import 'package:flutter_syntactic_sorter/model/piece.dart';
import 'package:flutter_syntactic_sorter/repository/utils/piece_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  Future<List<Piece>> getPieces(int level) async => Future.value(PieceFactory.getRandomPieces(level));
}
