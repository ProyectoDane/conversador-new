import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:meta/meta.dart';

/// A level in the game.
/// Contains its corresponding stages.
class Level {
  /// Creates a level with the specified information
  Level({@required this.stages, 
        @required this.id});

  /// The level's stages in the order they should be played.
  final List<Stage> stages;

  /// The level id
  final int id;
}
