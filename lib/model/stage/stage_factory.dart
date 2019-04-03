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

/// Factory for getting the needed stages.
class StageFactory {

  /// Returns a random stage based on the specified difficulty.
  static Stage getStage(final int difficulty) => <int, Stage>{
        Stage.DIFFICULTY_EASY: _getEasyStage(),
        Stage.DIFFICULTY_NORMAL: _getNormalStage(),
        Stage.DIFFICULTY_HARD: _getHardStage(),
        Stage.DIFFICULTY_MAX: _getMaxStage()
      }[difficulty];

  static Stage _getEasyStage() {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 100,
        maxDifficulty: Stage.DIFFICULTY_EASY,
        backgroundUri: 'assets/images/game/gaston_corre.jpg',
        sentence: Sentence(
          Subject(value: 'Gastón'),
          Predicate(value: 'corre'),
        ),
      ),
      Stage(
        id: 101,
        maxDifficulty: Stage.DIFFICULTY_EASY,
        backgroundUri: 'assets/images/game/pelusa_ronronea.jpg',
        sentence: Sentence(
          Subject(value: 'Pelusa'),
          Predicate(value: 'ronronea'),
        ),
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getNormalStage() {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 200,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/el_perro_come.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Modifier(value: 'el'),
            Entity(value: 'perro'),
          ]),
          Predicate(value: 'come'),
        ),
      ),
      Stage(
        id: 201,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/kim_come_fideos.jpg',
        sentence: Sentence(
            Subject(value: 'Kim'),
            Predicate.containing(<Concept>[
              Action(value: 'come'),
              Complement.containing(<Concept>[
                Entity(value: 'fideos'),
              ])
            ])
        ),
      ),
      Stage(
        id: 202,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/maria_y_alan_rien.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Entity(value: 'María'),
            Modifier(value: 'y'),
            Entity(value: 'Alan'),
          ]),
          Predicate(value: 'ríen'),
        ),
      ),
      Stage(
        id: 203,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/la_abuela_pinta.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Modifier(value: 'la'),
            Entity(value: 'abuela'),
          ]),
          Predicate(value: 'pinta'),
        ),
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getHardStage() {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 300,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/mariana_y_carla_juegan.jpg',
        sentence: Sentence(
            Subject.containing( <Concept>[
              Entity(value: 'Mariana'),
              Modifier(value: 'y'),
              Entity(value: 'Carla'),
            ]),
            Predicate.containing(<Concept>[
              Action(value: 'juegan'),
              Complement(value: 'contentas')
            ]),
        )
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getMaxStage() {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 400,
        maxDifficulty: Stage.DIFFICULTY_MAX,
        backgroundUri: 'assets/images/game/el_ninio_salta_la_soga.jpg',
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
      ),
      Stage(
        id: 401,
        maxDifficulty: Stage.DIFFICULTY_MAX,
        backgroundUri: 'assets/images/game/las_chicas_juegan_al_futbol.jpg',
        sentence: Sentence(
            Subject.containing(<Concept>[
              Modifier(value: 'las'),
              Entity(value: 'chicas'),
            ]),
            Predicate.containing(<Concept>[
              Action(value: 'juegan'),
              Complement.containing(<Concept>[
                Modifier(value: 'al'),
                Entity(value: 'fútbol'),
              ])
            ])
        ),
      ),
      Stage(
        id: 402,
        maxDifficulty: Stage.DIFFICULTY_MAX,
        backgroundUri: 'assets/images/game/juan_suenia_con_su_perro.jpg',
        sentence: Sentence(
          Subject(value: 'Juan'),
          Predicate.containing(<Concept>[
            Action(value: 'sueña'),
            Complement.containing(<Concept>[
              Complement(value: 'con'),
              Complement.containing(<Concept>[
                Modifier(value: 'su'),
                Entity(value: 'perro')
              ]),
            ]),
          ]),
        ),
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }
}
