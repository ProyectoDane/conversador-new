import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:meta/meta.dart';

class LiveStage {
  final Level level;
  final int amountOfConcept;
  final int amountOfSuccessful;

  LiveStage({@required Level level, int amountOfConcept, this.amountOfSuccessful = 0})
      : this.level = level,
        this.amountOfConcept = level.concepts.length;

  bool isLevelComplete() => amountOfSuccessful == amountOfConcept;

  factory LiveStage.updateLevelProgress(LiveStage liveStage) => LiveStage(
        level: liveStage.level,
        amountOfConcept: liveStage.amountOfConcept,
        amountOfSuccessful: liveStage.amountOfSuccessful + 1,
      );
}
