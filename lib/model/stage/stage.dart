import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/stage/live_stage.dart';
import 'package:meta/meta.dart';

class Stage {
  static const int DIFFICULTY_EASY = 1;
  static const int DIFFICULTY_NORMAL = 2;
  static const int DIFFICULTY_HARD = 3;
  static const int DIFFICULTY_MAX = 4;

  final int value;
  final int maxDifficulty;
  final String backgroundUri;
  final Sentence sentence;

  Stage({@required this.value, @required this.maxDifficulty, @required this.backgroundUri, @required this.sentence});

  LiveStage getInitialLiveStage() => LiveStage(
    sentence: sentence,
    difficulty: DIFFICULTY_EASY,
  );

  LiveStage getLiveStageForDifficulty(int difficulty) {
    if (difficulty > maxDifficulty) return null;
    return LiveStage(sentence: sentence, difficulty: difficulty);
  }

  LiveStage getFollowingLiveStage(int previousDifficulty) {
    if (previousDifficulty == maxDifficulty) return null;
    int nextDifficulty = previousDifficulty + 1;
    return LiveStage(sentence: sentence, difficulty: nextDifficulty);
  }

}
