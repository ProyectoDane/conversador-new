import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:meta/meta.dart';

/// A level in the game.
/// Contains its corresponding stages.
class Level {
  /// Creates a level with the specified information
  Level({@required this.id, 
        @required this.stageCount,
        @required this.isRandom});

  /// The level id
  int id;

  /// How many stages are in this level
  final int stageCount;

  /// This determines whether the stages are ordered by complexity or if they
  /// were chosen at random
  final bool isRandom;

  /// The level's stages list, which was ordered according to 
  /// the previous condition
  List<Stage> stages;

}
