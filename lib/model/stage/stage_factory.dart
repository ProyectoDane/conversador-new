import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/src/model_exports.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';

/// Factory for getting the needed stages.
class StageFactory {
  /// Get all stages sorted by mentalComplexity (from easiest to most difficult)
  List<Stage> getAllOrderedStages(BuildContext context) =>
      List<Stage>.from(_stages(context));

  /// Get all the stages that have a certain mentalComplexity
  List<Stage> getStagesOfComplexity(
          Complexity mentalComplexity, BuildContext context){
    
    final List<Stage> stages =  _stages(context)
    .where((Stage stage) => stage.mentalComplexity == mentalComplexity)
    .toList()
    ..sort((Stage stage1,Stage stage2)
      => stage1.complexityOrder.compareTo(stage2.complexityOrder)
    );

    return stages;
  }

  /// Get a number of Stages from the list with difficulty in ascending order.
  /// count: number of stages
  /// indexOffset: index from where the stage count will begin
  /// TODO: If the default stages and the user generated stages are combined
  /// before hand, remove the sorting code as use as is.
  List<Stage> getStagesByCount
  (int count, int indexOffset, BuildContext context) {
    final List<Stage> easyStages = getStagesOfComplexity(
      Complexity.easy, context);
    final List<Stage> normalStages = getStagesOfComplexity(
      Complexity.normal, context);
    final List<Stage> hardStages = getStagesOfComplexity(
      Complexity.hard, context);
    final List<Stage> expertStages = getStagesOfComplexity(
      Complexity.expert, context);

    final List<Stage> stages = easyStages
    ..addAll(normalStages)
    ..addAll(hardStages)
    ..addAll(expertStages);

    if (indexOffset > stages.length) {
      return null;
    }

    final List<Stage> selectedItems = <Stage>[];
    for (int i = indexOffset; i > indexOffset+count;i++) {
      if (i < stages.length) {
        selectedItems.add(stages[i]);
      } else {
        break;
      }
    }

    return selectedItems;
  }

  /// Get one random stage that has the required mentalComplexity.
  Stage getRandomStageOfComplexity(
    Complexity mentalComplexity, BuildContext context) {
    final List<Stage> possibleStages =
        getStagesOfComplexity(mentalComplexity, context);
    final int randomStageIndex = Random().nextInt(possibleStages.length);
    return possibleStages[randomStageIndex];
  }

  /// Return the Stage identified by the given id.
  Stage getStageFromId(int id, BuildContext context) =>
      _stages(context).firstWhere((Stage stage) => stage.id == id);

  List<Stage> _stages(BuildContext context) => <Stage>[
        Stage(
          id: 1,
          mentalComplexity: Complexity.easy,
          complexityOrder: 1,
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
          id: 2,
          mentalComplexity: Complexity.easy,
          complexityOrder: 2,
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
          id: 3,
          mentalComplexity: Complexity.easy,
          complexityOrder: 3,
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
          id: 4,
          mentalComplexity: Complexity.easy,
          complexityOrder: 4,
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
          id: 5,
          mentalComplexity: Complexity.normal,
          complexityOrder: 1,
          backgroundUri: 'assets/images/game/kim_come_fideos.jpg',
          sentence: Sentence(
              Subject(
                  value:
                      LangLocalizations.of(context).trans('stage_202_subject')),
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
          id: 6,
          mentalComplexity: Complexity.normal,
          complexityOrder: 2,
          backgroundUri: 'assets/images/game/maria_y_alan_rien.jpg',
          sentence: Sentence(
            Subject.containing(<Concept>[
              Entity(
                  value:
                      LangLocalizations.of(context).trans('stage_302_entity')),
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
          id: 7,
          mentalComplexity: Complexity.normal,
          complexityOrder: 3,
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
            id: 8,
            mentalComplexity: Complexity.normal,
            complexityOrder: 4,
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
          id: 9,
          mentalComplexity: Complexity.hard,
          complexityOrder: 1,
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
          id: 10,
          mentalComplexity: Complexity.expert,
          complexityOrder: 1,
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
