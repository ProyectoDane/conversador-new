import 'package:flutter_syntactic_sorter/model/sentence.dart';
import 'package:meta/meta.dart';

class LiveLevel {
  final Sentence sentence;
  final int amountOfConcept;
  final int amountOfSuccessful;

  LiveLevel({@required Sentence sentence, int amountOfConcept, this.amountOfSuccessful = 0})
      : this.sentence = sentence,
        this.amountOfConcept = sentence.concepts.length;

  bool isSentenceComplete() => amountOfSuccessful == amountOfConcept;

  factory LiveLevel.updateProgressLevel(LiveLevel liveLevel) => LiveLevel(
        sentence: liveLevel.sentence,
        amountOfConcept: liveLevel.amountOfConcept,
        amountOfSuccessful: liveLevel.amountOfSuccessful + 1,
      );
}
