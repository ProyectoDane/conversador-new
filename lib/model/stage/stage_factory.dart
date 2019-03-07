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
        backgroundUri: 'assets/images/game/run.jpg',
        sentence: Sentence(
          Subject(children: <Concept>[
            Entity(value: 'Gaston'),
          ]),
          Predicate(children: <Concept>[
            Action(value: 'corre'),
          ]),
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
        backgroundUri: 'assets/images/game/paint.jpg',
        sentence: Sentence(
          Subject(children: <Concept>[
            Modifier(value: 'el'),
            Entity(value: 'abuelo'),
          ]),
          Predicate(children: <Concept>[
            Action(value: 'pinta'),
          ]),
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
        backgroundUri: 'assets/images/game/football.jpg',
        sentence: Sentence(
            Subject(children: <Concept>[
              Modifier(value: 'el'),
              Entity(value: 'niño'),
            ]),
            Predicate(children: <Concept>[
              Action(value: 'juega'),
              Complement(value: 'alegremente'),
            ])),
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
        backgroundUri: 'assets/images/game/food.jpg',
        sentence: Sentence(
            Subject(children: <Concept>[
              Modifier(value: 'la'),
              Entity(value: 'niña'),
            ]),
            Predicate(children: <Concept>[
              Action(value: 'come'),
              Complement(children: <Concept>[
                Modifier(value: 'la'),
                Entity(value: 'comida'),
              ])
            ])),
      )
    ];
    final randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }
}
