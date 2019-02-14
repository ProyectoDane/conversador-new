import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

class StageFactory {
  static Stage getStage(int difficulty) => {
        Stage.DIFFICULTY_EASY: _getRunStage(),
        Stage.DIFFICULTY_NORMAL: _getPaintStage(),
        Stage.DIFFICULTY_HARD: _getFootballStage(),
        Stage.DIFFICULTY_MAX: _getFoodStage()
      }[difficulty];

  static Stage _getRunStage() => Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_EASY,
        backgroundUri: 'assets/images/game/run.jpg',
        sentence: _getRunSentence(),
      );

  static Sentence _getRunSentence() {
    final entity = Entity(value: 'Gaston');
    final action = Action(value: 'corre');

    final subject = Subject(children: <Concept>[entity]);
    final predicate = Predicate(children: <Concept>[action]);

    return Sentence(subject, predicate);
  }

  static Stage _getPaintStage() => Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/paint.jpg',
        sentence: _getPaintSentence(),
      );

  static Sentence _getPaintSentence() {
    final modifier = Modifier(value: 'el');
    final entity = Entity(value: 'abuelo');
    final action = Action(value: 'pinta');

    final subject = Subject(children: <Concept>[modifier, entity]);
    final predicate = Predicate(children: <Concept>[action]);

    return Sentence(subject, predicate);
  }

  static Stage _getFootballStage() => Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/football.jpg',
        sentence: _getFootballSentence(),
      );

  static Sentence _getFootballSentence() {
    final modifier = Modifier(value: 'el');
    final entity = Entity(value: 'niño');
    final action = Action(value: 'juega');
    final complement = Complement(value: 'alegremente');

    final subject = Subject(children: <Concept>[modifier, entity]);
    final predicate = Predicate(children: <Concept>[action, complement]);

    return Sentence(subject, predicate);
  }

  static Stage _getFoodStage() => Stage(
        value: 2,
        maxDifficulty: Stage.DIFFICULTY_MAX,
        backgroundUri: 'assets/images/game/food.jpg',
        sentence: _getFoodSentence(),
      );

  // TODO there is a bug when the word is repeated
  static Sentence _getFoodSentence() {
    final modifier = Modifier(value: 'la');
    final entity = Entity(value: 'niña');
    final action = Action(value: 'come');
    final complementModifier = Modifier(value: 'el');
    final complementEntity = Entity(value: 'almuerzo');

    final subject = Subject(children: <Concept>[modifier, entity]);
    final complement = Complement(children: <Concept>[complementModifier, complementEntity]);
    final predicate = Predicate(children: <Concept>[action, complement]);

    return Sentence(subject, predicate);
  }
}
