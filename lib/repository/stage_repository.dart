import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage_factory.dart';

/// Repository for handling the getting and setting of stages
class StageRepository {

  /// Returns a StageRepository
  factory StageRepository() => _instance;

  StageRepository._internal();

  static final StageRepository _instance = StageRepository._internal();

  // MARK: - Stages
  /// Get a random stage from the ones available.
  Future<Stage> getRandomStage(BuildContext context) async {
    final int difficulty = Random().nextInt(Stage.DIFFICULTY_MAX) + 1;
    return Future<Stage>.value(StageFactory.getStage(difficulty, context));
  }

}