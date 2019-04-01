import 'dart:math';
import 'package:flutter/widgets.dart';
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
  /// Get all stages sorted by difficulty (from easiest to most difficult)
  List<Stage> getAllOrderedStages(BuildContext context) =>
      List<Stage>.from(_stages(context));

  /// Get all the stages that have a certain difficulty
  List<Stage> getStagesOfDifficulty(int difficulty, BuildContext context) =>
      _stages(context)
          .where((Stage stage) => stage.difficulty == difficulty)
          .toList();

  /// Get one random stage that has the required difficulty.
  Stage getRandomStageOfDifficulty(int difficulty, BuildContext context) {
    final List<Stage> possibleStages =
        getStagesOfDifficulty(difficulty, context);
    final int randomStageIndex = Random().nextInt(possibleStages.length);
    return possibleStages[randomStageIndex];
  }

  /// Return the Stage identified by the given id.
  Stage getStageFromId(int id, BuildContext context) =>
      _stages(context).firstWhere((Stage stage) => stage.id == id);

  List<Stage> _stages(BuildContext context) => <Stage>[
        Stage(
          id: 100,
          difficulty: 1,
          backgroundUri: 'assets/images/game/gaston_corre.jpg',
          sentence: Sentence(
            Subject(
                value:
                    LangLocalizations.of(context).trans('stage_100_subject')),
            Predicate(
                value:
                    LangLocalizations.of(context).trans('stage_100_predicate')),
          ),
        ),
        Stage(
          id: 202,
          difficulty: 2,
          backgroundUri: 'assets/images/game/la_abuela_pinta.jpg',
          sentence: Sentence(
            Subject.containing(<Concept>[
              Modifier(
                  value: LangLocalizations.of(context)
                      .trans('stage_203_modifier')),
              Entity(
                  value:
                      LangLocalizations.of(context).trans('stage_203_entity')),
            ]),
            Predicate(
                value:
                    LangLocalizations.of(context).trans('stage_203_predicate')),
          ),
        ),
        Stage(
          id: 200,
          difficulty: 3,
          backgroundUri: 'assets/images/game/el_perro_come.jpg',
          sentence: Sentence(
            Subject.containing(<Concept>[
              Modifier(
                  value: LangLocalizations.of(context)
                      .trans('stage_201_modifier')),
              Entity(
                  value:
                      LangLocalizations.of(context).trans('stage_201_entity')),
            ]),
            Predicate(
                value:
                    LangLocalizations.of(context).trans('stage_201_predicate')),
          ),
        ),
        Stage(
          id: 101,
          difficulty: 4,
          backgroundUri: 'assets/images/game/pelusa_ronronea.jpg',
          sentence: Sentence(
            Subject(
                value:
                    LangLocalizations.of(context).trans('stage_101_subject')),
            Predicate(
                value:
                    LangLocalizations.of(context).trans('stage_101_predicate')),
          ),
        ),
        Stage(
          id: 401,
          difficulty: 5,
          backgroundUri: 'assets/images/game/kim_come_fideos.jpg',
          sentence: Sentence(
              Subject(
                  value:
                      LangLocalizations.of(context).trans('stage_202_entity')),
              Predicate.containing(<Concept>[
                Action(
                    value: LangLocalizations.of(context)
                        .trans('stage_202_action')),
                Complement(
                    value: LangLocalizations.of(context)
                        .trans('stage_202_complement')),
              ])),
        ),
        Stage(
          id: 201,
          difficulty: 6,
          backgroundUri: 'assets/images/game/maria_y_alan_rien.jpg',
          sentence: Sentence(
            Subject.containing(<Concept>[
              Entity(
                  value: LangLocalizations.of(context)
                      .trans('stage_302_entity')),
              Modifier(
                  value: LangLocalizations.of(context)
                      .trans('stage_302_modifier')),
              Entity(
                  value: LangLocalizations.of(context)
                      .trans('stage_302_entity_2')),
            ]),
            Predicate(
                value:
                    LangLocalizations.of(context).trans('stage_302_predicate')),
          ),
        ),
        Stage(
          id: 400,
          difficulty: 7,
          backgroundUri: 'assets/images/game/el_ninio_salta_la_soga.jpg',
          sentence: Sentence(
              Subject.containing(<Concept>[
                Modifier(
                    value: LangLocalizations.of(context)
                        .trans('stage_300_modifier')),
                Entity(
                    value: LangLocalizations.of(context)
                        .trans('stage_300_entity')),
              ]),
              Predicate.containing(<Concept>[
                Action(
                    value: LangLocalizations.of(context)
                        .trans('stage_300_action')),
                Complement(
                    value: LangLocalizations.of(context)
                        .trans('stage_300_complement')),
              ])),
        ),
        Stage(
            id: 300,
            difficulty: 8,
            backgroundUri:
                'assets/images/game/mariana_y_carla_juegan_contentas.jpg',
            sentence: Sentence(
              Subject.containing(<Concept>[
                Entity(
                    value: LangLocalizations.of(context)
                        .trans('stage_400_entity')),
                Modifier(
                    value: LangLocalizations.of(context)
                        .trans('stage_400_modifier')),
                Entity(
                    value: LangLocalizations.of(context)
                        .trans('stage_400_entity_2')),
              ]),
              Predicate.containing(<Concept>[
                Action(
                    value: LangLocalizations.of(context)
                        .trans('stage_400_action')),
                Complement(
                    value: LangLocalizations.of(context)
                        .trans('stage_400_complement')),
              ]),
            )),
        Stage(
          id: 402,
          difficulty: 9,
          backgroundUri: 'assets/images/game/las_chicas_juegan_al_futbol.jpg',
          sentence: Sentence(
              Subject.containing(<Concept>[
                Modifier(
                    value: LangLocalizations.of(context)
                        .trans('stage_301_modifier')),
                Entity(
                    value: LangLocalizations.of(context)
                        .trans('stage_301_entity')),
              ]),
              Predicate.containing(<Concept>[
                Action(
                    value: LangLocalizations.of(context)
                        .trans('stage_301_action')),
                Complement(
                    value: LangLocalizations.of(context)
                        .trans('stage_301_complement')),
              ])),
        ),
        Stage(
          id: 403,
          difficulty: 10,
          backgroundUri: 'assets/images/game/juan_suenia_con_su_perro.jpg',
          sentence: Sentence(
            Subject(
                value:
                    LangLocalizations.of(context).trans('stage_200_subject')),
            Predicate.containing(<Concept>[
              Action(
                  value:
                      LangLocalizations.of(context).trans('stage_200_action')),
              Complement(
                  value: LangLocalizations.of(context)
                      .trans('stage_200_complement')),
            ]),
          ),
        ),
      ];
}
