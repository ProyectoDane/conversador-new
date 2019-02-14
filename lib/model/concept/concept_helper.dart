import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';

class ConceptHelper {
  static List<Concept> getEasyConcepts(sentence) => <Concept>[
        Subject(value: _getSubjectValue(sentence)),
        Predicate(value: _getPredicateValue(sentence)),
      ];

  static List<Concept> getNormalConcepts(sentence) => <Concept>[
        Modifier(value: _getSubjectModifierValue(sentence)),
        Entity(value: _getSubjectEntityValue(sentence)),
        Predicate(value: _getPredicateValue(sentence)),
      ];

  static List<Concept> getHardConcepts(sentence) => <Concept>[
        Modifier(value: _getSubjectModifierValue(sentence)),
        Entity(value: _getSubjectEntityValue(sentence)),
        Action(value: _getActionValue(sentence)),
        Complement(value: _getComplementValue(sentence)),
      ];

  static List<Concept> getMaxConcepts(sentence) => <Concept>[
        Modifier(value: _getSubjectModifierValue(sentence)),
        Entity(value: _getSubjectEntityValue(sentence)),
        Action(value: _getActionValue(sentence)),
        Modifier(value: _getPredicateModifierValue(sentence)),
        Entity(value: _getPredicateEntityValue(sentence)),
      ];

  static String _getSubjectValue(sentence) => _reduceChildren(_getSubjectChildren(sentence));

  static String _getPredicateValue(sentence) => _reduceChildren(_getPredicateChildren(sentence));

  static String _getSubjectModifierValue(sentence) => _getSubjectModifier(sentence).value;

  static String _getSubjectEntityValue(sentence) => _getSubjectEntity(sentence).value;

  static String _getActionValue(sentence) => _getAction(sentence).value;

  static String _getComplementValue(sentence) => _hasChildren(_getPredicateComplement(sentence))
      ? _reduceChildren(_getPredicateComplementChildren(sentence))
      : _getPredicateComplement(sentence).value;

  static String _getPredicateModifierValue(sentence) => _getPredicateModifier(sentence).value;

  static String _getPredicateEntityValue(sentence) => _getPredicateEntity(sentence).value;

  static String _reduceChildren(List<Concept> children) {
    String result = '';
    if (children.isEmpty) {
      return result;
    }

    for (Concept concept in children) {
      result = result + ' ' + (concept.children.isEmpty ? concept.value : _reduceChildren(concept.children));
    }
    return result;
  }

  static List<Concept> _getSubjectChildren(sentence) => sentence.subject.children;

  static List<Concept> _getPredicateChildren(sentence) => sentence.predicate.children;

  static Concept _getSubjectModifier(sentence) => _getSubjectChildren(sentence)[0];

  static Concept _getSubjectEntity(sentence) => _getSubjectChildren(sentence)[1];

  static Concept _getAction(sentence) => _getPredicateChildren(sentence)[0];

  static Concept _getPredicateComplement(sentence) => _getPredicateChildren(sentence)[1];

  static List<Concept> _getPredicateComplementChildren(sentence) => _getPredicateComplement(sentence).children;

  static Concept _getPredicateModifier(sentence) => _getPredicateComplementChildren(sentence)[0];

  static Concept _getPredicateEntity(sentence) => _getPredicateComplementChildren(sentence)[1];

  static bool _hasChildren(concept) => concept.children.isNotEmpty;
}
