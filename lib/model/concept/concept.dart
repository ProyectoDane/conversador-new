import 'dart:math';

import 'package:meta/meta.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';

/// Class representing a Concept inside a Sentence.
/// There are many types os concepts,
/// there are even some ones that are larger than others
/// and even contain other concepts.
abstract class Concept {

  /// Creates a concept with certain children and concept type
  /// (its value and depth will be taken from the children).
  Concept.intermediate({@required this.children, @required this.type})
      : value = _reduceChildren(children),
        depth = _getChildrenDepth(children);

  /// Creates a concept with a certain value and concept type
  /// (no children and depth == 0).
  Concept.terminal({@required this.value, @required this.type})
      : children = <Concept>[],
        depth = 0;

  /// Concepts it contains
  final List<Concept> children;
  /// The value this particular concept represents.
  final String value;
  /// Depth is the quantity of descendants levels there are.
  /// If it has no children, it's 0; if it has many terminal children's 1;
  /// if it has at least one grandchildren, 2; etc...
  final int depth;
  /// Concept type id.
  final int type;

  @override
  bool operator ==(dynamic other) =>
      other is Concept && value == other.value && type == other.type;

  @override
  int get hashCode => value.hashCode ^ type.hashCode;
}

String _reduceChildren(List<Concept> children) {
  if (children.isEmpty) {
    return '';
  }
  final String result = reduce(
    children,
    '',
    (String phrase, Concept concept) => '$phrase ${concept.value}',
  );
  return result.trim();
}

int _getChildrenDepth(List<Concept> children) {
  if (children.isEmpty) {
    return 0;
  }

  final int childrenDepth = reduce(
    children,
    0,
    (int maxDepth, Concept concept) => max(maxDepth, concept.depth),
  );
  return childrenDepth + 1;
}
