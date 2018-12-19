import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/repository/utils/random_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  Future<List<Word>> getWords(int level) async => Future.value(RandomFactory.getRandomWords(level));
}
