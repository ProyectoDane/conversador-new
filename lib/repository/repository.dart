import 'dart:math';

import 'package:flutter_syntactic_sorter/model/level.dart';
import 'package:flutter_syntactic_sorter/repository/utils/level_factory.dart';

class Repository {
  static var _instance = Repository.internal();

  factory Repository({apiService, dao}) => _instance;

  Repository.internal();

  Future<Level> getRandomLevel() async {
    final level = Random().nextInt(2);
    return Future.value(LevelFactory.getLevel(level));
  }
}
