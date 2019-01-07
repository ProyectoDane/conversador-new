import 'package:flutter_syntactic_sorter/model/word.dart';
import 'package:flutter_syntactic_sorter/repository/utils/piece_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  Future<List<Word>> getWords(int level) async => Future.value(PieceFactory.getRandomWords(level));
}
