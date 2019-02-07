import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate_core.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject_core.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

class StageFactory {
  static Stage getStage(int stage) => stage == 0 ? _getFootballStage() : _getFoodStage();

  static Stage _getFootballStage() => Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/football.jpg',
        concepts: _getFootballExample(),
      );

  static List<Concept> _getFootballExample() {
    final modifier = Modifier(value: 'el');
    final subjectCore = SubjectCore(value: 'niño');
    final predicateCore = PredicateCore(value: 'juega');
    final complement = Complement(value: 'alegremente');

    final subject = Subject(concepts: <Concept>[modifier, subjectCore]);
    final predicate = Predicate(concepts: <Concept>[predicateCore, complement]);

    return <Concept>[subject, predicate];
  }

  static Stage _getFoodStage() => Stage(
        value: 2,
        maxDifficulty: Stage.DIFFICULTY_MAX,
        backgroundUri: 'assets/images/game/food.jpg',
        concepts: _getFoodExample(),
      );

  // TODO there is a bug when the word is repeated
  static List<Concept> _getFoodExample() {
    final modifier = Modifier(value: 'la');
    final subjectCore = SubjectCore(value: 'niña');
    final predicateCore = PredicateCore(value: 'come');
    final complementModifier = Modifier(value: 'el');
    final complementSubject = SubjectCore(value: 'almuerzo');

    final subject = Subject(concepts: <Concept>[modifier, subjectCore]);
    final complement = Complement(concepts: <Concept>[complementModifier, complementSubject]);
    final predicate = Predicate(concepts: <Concept>[predicateCore, complement]);

    return <Concept>[subject, predicate];
  }
}
