import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';
import 'package:meta/meta.dart';

/// Represents a Stage in the game:
/// - its id
/// - the related image's uri
/// - a sentence
/// - the mental complexity 
/// - the order relative to others of the same complexity
class Stage {
  /// Creates a Stage with the given information.
  Stage(
      {@required this.id,
      @required this.backgroundUri,
      @required this.sentence,
      @required this.mentalComplexity,
      @required this.complexityOrder,
      @required this.stageSentenceString})
      : maximumDepth = ConceptHelper.getSentenceDepth(sentence);

  /// Creates a stage to be stored or retrieved from the database
  Stage.data(
    {this.id, 
    this.backgroundUri, 
    this.mentalComplexity, 
    this.complexityOrder,
    this.stageSentenceString});

  /// Stage's id
  int id;

  /// Uri of the related image
  final String backgroundUri;

  /// Sentence used in this stage
  Sentence sentence;

  /// Mental complexity of the stage
  /// (related to the mental difficulty associated with the phrase)
  final Complexity mentalComplexity;

  /// Order of mental complexity
  /// Multiple Stages may be grouped in the same relative
  /// complexity, but have a relative order.
  final int complexityOrder;

  /// A plain string represeting the phrase in the stage
  final String stageSentenceString;

  /// Maximum depth of the stage
  /// (Related to the phrase and its subdivisions)
  int maximumDepth;

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
