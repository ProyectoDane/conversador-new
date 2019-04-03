import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:meta/meta.dart';

/// Represents a Stage in the game:
/// - a sentence,
/// - the maximum difficulty it can reach
/// - the related image's uri
/// - its id
class Stage {

  /// Creates a Stage with the given information.
  Stage({
    @required this.id,
    @required this.maxDifficulty,
    @required this.backgroundUri,
    @required this.sentence
  });

  /// Easiest difficulty
  static const int DIFFICULTY_EASY = 1;
  /// Normal difficulty (second easiest)
  static const int DIFFICULTY_NORMAL = 2;
  /// Hard difficulty (third easiest)
  static const int DIFFICULTY_HARD = 3;
  /// Max difficulty (hardest difficulty)
  static const int DIFFICULTY_MAX = 4;

  /// Stage's id
  final int id;
  /// Maximum difficulty this stage can reach
  /// (maximum quantity of levels)
  final int maxDifficulty;
  /// Uri of the related image
  final String backgroundUri;
  /// Sentence used in this stage
  final Sentence sentence;

  /// First easiest LiveStage possible
  LiveStage getInitialLiveStage() => LiveStage(
    sentence: sentence,
    difficulty: DIFFICULTY_EASY,
  );

  /// Returns a LiveStage based on the difficulty required
  LiveStage getLiveStageForDifficulty(int difficulty) {
    if (difficulty > maxDifficulty) {
      return null;
    }
    return LiveStage(sentence: sentence, difficulty: difficulty);
  }

  /// Get the live stage related to the difficulty following the one given
  LiveStage getFollowingLiveStage(int previousDifficulty) {
    if (previousDifficulty == maxDifficulty) {
      return null;
    }
    final int nextDifficulty = previousDifficulty + 1;
    return LiveStage(sentence: sentence, difficulty: nextDifficulty);
  }

}
