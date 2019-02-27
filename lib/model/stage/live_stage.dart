import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

class LiveStage {
  final List<Concept> concepts;
  final int amountOfConcept;
  final int amountOfSuccessful;

  LiveStage({@required List<Concept> concepts, int amountOfConcept, this.amountOfSuccessful = 0})
      : this.concepts = concepts,
        this.amountOfConcept = concepts.length;

  bool isLevelComplete() => amountOfSuccessful == amountOfConcept;

  factory LiveStage.updateLevelProgress(final LiveStage liveStage) => LiveStage(
        concepts: liveStage.concepts,
        amountOfConcept: liveStage.amountOfConcept,
        amountOfSuccessful: liveStage.amountOfSuccessful + 1,
      );
}
