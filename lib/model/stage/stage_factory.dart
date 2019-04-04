import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';

/// Factory for getting the needed stages.
class StageFactory {
  /// Returns a random stage based on the specified difficulty.
  static Stage getStage(final int difficulty, BuildContext context) =>
      <int, Stage>{
        Stage.DIFFICULTY_EASY: _getEasyStage(context),
        Stage.DIFFICULTY_NORMAL: _getNormalStage(context),
        Stage.DIFFICULTY_HARD: _getHardStage(context),
        Stage.DIFFICULTY_MAX: _getMaxStage(context)
      }[difficulty];

  static Stage _getEasyStage(BuildContext context) {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 100,
        maxDifficulty: Stage.DIFFICULTY_EASY,
        backgroundUri: 'assets/images/game/gaston_corre.jpg',
        sentence: Sentence(
          Subject(
              value: LangLocalizations.of(context).trans('stage_100_subject')),
          Predicate(
              value:
                  LangLocalizations.of(context).trans('stage_100_predicate')),
        ),
      ),
      Stage(
        id: 101,
        maxDifficulty: Stage.DIFFICULTY_EASY,
        backgroundUri: 'assets/images/game/pelusa_ronronea.jpg',
        sentence: Sentence(
          Subject(
              value: LangLocalizations.of(context).trans('stage_101_subject')),
          Predicate(
              value:
                  LangLocalizations.of(context).trans('stage_101_predicate')),
        ),
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getNormalStage(BuildContext context) {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 200,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/juan_suenia_con_su_perro.jpg',
        sentence: Sentence(
          Subject(
              value: LangLocalizations.of(context).trans('stage_200_subject')),
          Predicate.containing(<Concept>[
            Action(
                value: LangLocalizations.of(context).trans('stage_200_action')),
            Complement(
                value: LangLocalizations.of(context)
                    .trans('stage_200_complement')),
          ]),
        ),
      ),
      Stage(
        id: 201,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/el_perro_come.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Modifier(
                value:
                    LangLocalizations.of(context).trans('stage_201_modifier')),
            Entity(
                value: LangLocalizations.of(context).trans('stage_201_entity')),
          ]),
          Predicate(
              value:
                  LangLocalizations.of(context).trans('stage_201_predicate')),
        ),
      ),
      Stage(
        id: 202,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/kim_come_fideos.jpg',
        sentence: Sentence(
            Subject(
                value: LangLocalizations.of(context).trans('stage_202_entity')),
            Predicate.containing(<Concept>[
              Action(
                  value:
                      LangLocalizations.of(context).trans('stage_202_action')),
              Complement(
                  value: LangLocalizations.of(context)
                      .trans('stage_202_complement')),
            ])),
      ),
      Stage(
        id: 203,
        maxDifficulty: Stage.DIFFICULTY_NORMAL,
        backgroundUri: 'assets/images/game/la_abuela_pinta.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Modifier(
                value:
                    LangLocalizations.of(context).trans('stage_203_modifier')),
            Entity(
                value: LangLocalizations.of(context).trans('stage_203_entity')),
          ]),
          Predicate(
              value:
                  LangLocalizations.of(context).trans('stage_203_predicate')),
        ),
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getHardStage(BuildContext context) {
    final List<Stage> stages = <Stage>[
      Stage(
        id: 300,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/el_ninio_salta_la_soga.jpg',
        sentence: Sentence(
            Subject.containing(<Concept>[
              Modifier(
                  value: LangLocalizations.of(context)
                      .trans('stage_300_modifier')),
              Entity(
                  value:
                      LangLocalizations.of(context).trans('stage_300_entity')),
            ]),
            Predicate.containing(<Concept>[
              Action(
                  value:
                      LangLocalizations.of(context).trans('stage_300_action')),
              Complement(
                  value: LangLocalizations.of(context)
                      .trans('stage_300_complement')),
            ])),
      ),
      Stage(
        id: 301,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/las_chicas_juegan_al_futbol.jpg',
        sentence: Sentence(
            Subject.containing(<Concept>[
              Modifier(
                  value: LangLocalizations.of(context)
                      .trans('stage_301_modifier')),
              Entity(
                  value:
                      LangLocalizations.of(context).trans('stage_301_entity')),
            ]),
            Predicate.containing(<Concept>[
              Action(
                  value:
                      LangLocalizations.of(context).trans('stage_301_action')),
              Complement(
                  value: LangLocalizations.of(context)
                      .trans('stage_301_complement')),
            ])),
      ),
      Stage(
        id: 302,
        maxDifficulty: Stage.DIFFICULTY_HARD,
        backgroundUri: 'assets/images/game/maria_y_alan_rien.jpg',
        sentence: Sentence(
          Subject.containing(<Concept>[
            Entity(
                value: LangLocalizations.of(context)
                    .trans('stage_100_stage_302_entitysubject')),
            Modifier(
                value:
                    LangLocalizations.of(context).trans('stage_302_modifier')),
            Entity(
                value:
                    LangLocalizations.of(context).trans('stage_302_entity_2')),
          ]),
          Predicate(
              value:
                  LangLocalizations.of(context).trans('stage_302_predicate')),
        ),
      ),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }

  static Stage _getMaxStage(BuildContext context) {
    final List<Stage> stages = <Stage>[
      Stage(
          id: 400,
          maxDifficulty: Stage.DIFFICULTY_MAX,
          backgroundUri: 'assets/images/game/mariana_y_carla_juegan.jpg',
          sentence: Sentence(
            Subject.containing(<Concept>[
              Entity(
                  value:
                      LangLocalizations.of(context).trans('stage_400_entity')),
              Modifier(
                  value: LangLocalizations.of(context)
                      .trans('stage_400_modifier')),
              Entity(
                  value: LangLocalizations.of(context)
                      .trans('stage_400_entity_2')),
            ]),
            Predicate.containing(<Concept>[
              Action(
                  value:
                      LangLocalizations.of(context).trans('stage_400_action')),
              Complement(
                  value: LangLocalizations.of(context)
                      .trans('stage_400_complement')),
            ]),
          )),
    ];
    final int randomStageIndex = Random().nextInt(stages.length);
    return stages[randomStageIndex];
  }
}
