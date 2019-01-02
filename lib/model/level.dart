import 'package:meta/meta.dart';

class Level {
  final int value;
  final int amountOfSuccessful;
  final int amountOfWords;

  Level({@required this.value, @required this.amountOfSuccessful, @required this.amountOfWords});

  bool isLevelCompleted() => amountOfSuccessful == amountOfWords;

  factory Level.initial() => Level(value: 1, amountOfSuccessful: 0, amountOfWords: 1);

  factory Level.updateProgressLevel(Level level) => Level(
        value: level.value,
        amountOfSuccessful: level.amountOfSuccessful + 1,
        amountOfWords: level.amountOfWords,
      );

  factory Level.nextLevel(Level level) => Level(
        value: level.value + 1,
        amountOfSuccessful: 0,
        amountOfWords: level.amountOfWords + 1,
      );
}
