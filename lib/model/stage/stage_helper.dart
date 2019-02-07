import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate_core.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject_core.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

class StageHelper {
  static int increaseDifficulty(int currentDifficulty) {
    return currentDifficulty + 1;
  }

  static List<Concept> getConceptsByDifficulty(List<Concept> concepts, int currentDifficulty) {
    switch (currentDifficulty) {
      case Stage.DIFFICULTY_EASY:
        return _getEasyConcepts(concepts);
      case Stage.DIFFICULTY_NORMAL:
        return _getNormalConcepts(concepts);
      case Stage.DIFFICULTY_HARD:
        return _getHardConcepts(concepts);
      case Stage.DIFFICULTY_MAX:
      default:
        return _getMaxConcepts(concepts);
    }
  }

  // TODO improve this PLEASE!
  static List<Concept> _getEasyConcepts(List<Concept> concepts) {
    final subjectText = joinChildren(concepts[0].concepts);
    final predicateText = joinChildren(concepts[1].concepts);
    return <Concept>[
      Subject(value: subjectText, concepts: concepts[0].concepts),
      Predicate(value: predicateText, concepts: concepts[1].concepts),
    ];
  }

  static List<Concept> _getNormalConcepts(List<Concept> concepts) {
    final modifierText = concepts[0].concepts[0].value;
    final subjectCoreText = concepts[0].concepts[1].value;
    final predicateText = joinChildren(concepts[1].concepts);

    return <Concept>[
      Modifier(value: modifierText, concepts: concepts[0].concepts[0].concepts),
      SubjectCore(value: subjectCoreText, concepts: concepts[0].concepts[1].concepts),
      Predicate(value: predicateText, concepts: concepts[1].concepts),
    ];
  }

  static String joinChildren(List<Concept> concepts) {
    String result = '';
    for (Concept concept in concepts) {
      if (concept.concepts == null) {
        result = result + ' ' + concept.value;
      } else {
        result = result + ' ' + joinChildren(concept.concepts);
      }
    }
    return result;
  }

  static List<Concept> _getHardConcepts(List<Concept> concepts) {
    final modifierText = concepts[0].concepts[0].value;
    final subjectCoreText = concepts[0].concepts[1].value;
    final predicateCoreText = concepts[1].concepts[0].value;
    final complementText = concepts[1].concepts[1].concepts == null
        ? concepts[1].concepts[1].value
        : joinChildren(concepts[1].concepts[1].concepts);

    return <Concept>[
      Modifier(value: modifierText, concepts: concepts[0].concepts[0].concepts),
      SubjectCore(value: subjectCoreText, concepts: concepts[0].concepts[1].concepts),
      PredicateCore(value: predicateCoreText, concepts: concepts[1].concepts[0].concepts),
      Complement(value: complementText, concepts: concepts[1].concepts[1].concepts),
    ];
  }

  static List<Concept> _getMaxConcepts(List<Concept> concepts) {
    final modifierText = concepts[0].concepts[0].value;
    final subjectCoreText = concepts[0].concepts[1].value;
    final predicateCoreText = concepts[1].concepts[0].value;
    final complementModifierText = concepts[1].concepts[1].concepts[0].value;
    final complementCoreText = concepts[1].concepts[1].concepts[1].value;

    return <Concept>[
      Modifier(value: modifierText, concepts: concepts[0].concepts[0].concepts),
      SubjectCore(value: subjectCoreText, concepts: concepts[0].concepts[1].concepts),
      PredicateCore(value: predicateCoreText, concepts: concepts[1].concepts[0].concepts),
      Modifier(value: complementModifierText, concepts: concepts[1].concepts[1].concepts[0].concepts),
      SubjectCore(value: complementCoreText, concepts: concepts[1].concepts[1].concepts[1].concepts),
    ];
  }
}
