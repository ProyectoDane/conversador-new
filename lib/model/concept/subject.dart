import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:meta/meta.dart';

/// Concept that represents the subject of a sentence.
class Subject extends Concept {
  /// Creates a Subject with a value
  Subject({@required String value}) : super.terminal(value: value, type: TYPE);

  /// Creates a Subject with its children concepts
  Subject.containing(List<Concept> children)
      : super.intermediate(children: children, type: TYPE);

  /// Creates a subject to be stored or retrieved from the database
  Subject.data({int id, String value, this.sentenceId})
      : super.terminal(value: value, type: TYPE, id: id);

  /// The sentence this subject belongs to
  int sentenceId;

  /// Concept type id for Subjects.
  static const int TYPE = 10;
}
