import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
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
  Stage(
      {@required this.id,
      @required this.backgroundUri,
      @required this.sentence,
      @required this.difficulty})
      : maximumDepth = ConceptHelper.getSentenceDepth(sentence);

  /// Stage's id
  final int id;

  /// Uri of the related image
  final String backgroundUri;

  /// Sentence used in this stage
  final Sentence sentence;

  /// Difficulty of the stage
  /// (related to the mental difficult associated with the phrase)
  final int difficulty;

  /// Maximum depth of the stage
  /// (Related to the phrase and its subdivisions)
  final int maximumDepth;

  /// First easiest LiveStage possible
  LiveStage getInitialLiveStage() => LiveStage(
        sentence: sentence,
        depth: 0,
      );

  /// Returns a LiveStage based on the depth required
  LiveStage getLiveStageForDepth(int depth) {
    if (depth > maximumDepth) {
      return null;
    }
    return LiveStage(sentence: sentence, depth: depth);
  }

  /// Get the live stage related to the depth following the one given
  LiveStage getFollowingLiveStage(int previousDepth) {
    if (previousDepth == maximumDepth) {
      return null;
    }
    return LiveStage(sentence: sentence, depth: previousDepth + 1);
  }
}
