import 'dart:math';

import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

// TODO there is a bug when the word is repeated
class StageFactory {
  static Stage getStage(final int difficulty) => {
        Stage.DIFFICULTY_EASY: _getEasyStage(),
        Stage.DIFFICULTY_NORMAL: _getNormalStage(),
        Stage.DIFFICULTY_HARD: _getHardStage(),
        Stage.DIFFICULTY_MAX: _getMaxStage()
      }[difficulty];

  static Stage _getEasyStage() {
    final List<Stage> stages = [
      Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_EASY,
        backgroundUri: 'assets/images/game/juan_suenia.jpg',
        sentence: Sentence(
          Subject(value: 'Juan'),
          Predicate(value: 'sueña'),
        ),
      )
    ];
    final randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getNormalStage() {
    final List<Stage> stages = [
      Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/el_perro_come.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Modifier(value: 'el'),
            Entity(value: 'perro'),
          ]),
          Predicate(value: 'come'),
        ),
      )
    ];
    final randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getHardStage() {
    final List<Stage> stages = [
      Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/mariana_y_carla_juegan.jpg',
        sentence: Sentence(
            Subject.containing( <Concept>[
              Entity(value: 'Mariana'),
              Modifier(value: 'y'),
              Entity(value: 'Carla'),
            ]),
            Predicate.containing([
              Action(value: 'juegan'),
              Complement(value: 'juntas')
            ]),
        )
      )
    ];
    final randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getMaxStage() {
    final List<Stage> stages = [
      Stage(
        value: 1,
        maxDifficulty: Stage.DIFFICULTY_MAX,
        backgroundUri: 'assets/images/game/el_ninio_salta_la_sogajpg',
        sentence: Sentence(
            Subject.containing(<Concept>[
              Modifier(value: 'el'),
              Entity(value: 'niño'),
            ]),
            Predicate.containing(<Concept>[
              Action(value: 'salta'),
              Complement.containing(<Concept>[
                Modifier(value: 'la'),
                Entity(value: 'soga'),
              ])
            ])
        ),
      )
    ];
    final randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }
}
