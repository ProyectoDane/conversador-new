import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/repository/utils/level_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  Future<Level> getRandomLevel() async => Future.value(LevelFactory.getLevel());
}
