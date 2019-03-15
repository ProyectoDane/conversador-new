import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';

class ConceptHelper {
  static List<Concept> getEasyConcepts(final Sentence sentence) => <Concept>[
        Subject(value: _getSubjectValue(sentence)),
        Predicate(value: _getPredicateValue(sentence)),
      ];

  static List<Concept> getNormalConcepts(final Sentence sentence) => <Concept>[
        Modifier(value: _getSubjectModifierValue(sentence)),
        Entity(value: _getSubjectEntityValue(sentence)),
        Predicate(value: _getPredicateValue(sentence)),
      ];

  static List<Concept> getHardConcepts(final Sentence sentence) => <Concept>[
        Modifier(value: _getSubjectModifierValue(sentence)),
        Entity(value: _getSubjectEntityValue(sentence)),
        Action(value: _getActionValue(sentence)),
        Complement(value: _getComplementValue(sentence)),
      ];

  static List<Concept> getMaxConcepts(final Sentence sentence) => <Concept>[
        Modifier(value: _getSubjectModifierValue(sentence)),
        Entity(value: _getSubjectEntityValue(sentence)),
        Action(value: _getActionValue(sentence)),
        Modifier(value: _getPredicateModifierValue(sentence)),
        Entity(value: _getPredicateEntityValue(sentence)),
      ];

  static String _getSubjectValue(final Sentence sentence) => _reduceChildren(_getSubjectChildren(sentence));

  static String _getPredicateValue(final Sentence sentence) => _reduceChildren(_getPredicateChildren(sentence));

  static String _getSubjectModifierValue(final Sentence sentence) => _getSubjectModifier(sentence).value;

  static String _getSubjectEntityValue(final Sentence sentence) => _getSubjectEntity(sentence).value;

  static String _getActionValue(final Sentence sentence) => _getAction(sentence).value;

  static String _getComplementValue(final Sentence sentence) => _hasChildren(_getPredicateComplement(sentence))
      ? _reduceChildren(_getPredicateComplementChildren(sentence))
      : _getPredicateComplement(sentence).value;

  static String _getPredicateModifierValue(final Sentence sentence) => _getPredicateModifier(sentence).value;

  static String _getPredicateEntityValue(final Sentence sentence) => _getPredicateEntity(sentence).value;

  static String _reduceChildren(final List<Concept> children) {
    String result = '';
    if (children.isEmpty) {
      return result;
    }
    for (Concept concept in children) {
      result = result + (concept.children.isEmpty ? concept.value : _reduceChildren(concept.children)) + ' ';
    }
    return result.substring(0, result.length - 1);  // Remove last space
  }

  static List<Concept> _getSubjectChildren(final Sentence sentence) => sentence.subject.children;

  static List<Concept> _getPredicateChildren(final Sentence sentence) => sentence.predicate.children;

  static Concept _getSubjectModifier(final Sentence sentence) => _getSubjectChildren(sentence)[0];

  static Concept _getSubjectEntity(final Sentence sentence) => _getSubjectChildren(sentence)[1];

  static Concept _getAction(final Sentence sentence) => _getPredicateChildren(sentence)[0];

  static Concept _getPredicateComplement(final Sentence sentence) => _getPredicateChildren(sentence)[1];

  static List<Concept> _getPredicateComplementChildren(final Sentence sentence) => _getPredicateComplement(sentence).children;

  static Concept _getPredicateModifier(final Sentence sentence) => _getPredicateComplementChildren(sentence)[0];

  static Concept _getPredicateEntity(final Sentence sentence) => _getPredicateComplementChildren(sentence)[1];

  static bool _hasChildren(final Concept concept) => concept.children.isNotEmpty;
}
