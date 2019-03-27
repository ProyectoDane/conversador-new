import 'dart:math';

import 'package:meta/meta.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';

abstract class Concept {

  Concept.intermediate({@required this.children, @required this.type})
      : value = _reduceChildren(children),
        depth = _getChildrenDepth(children);

  Concept.terminal({@required this.value, @required this.type})
      : children = <Concept>[],
        depth = 0;

  final List<Concept> children;
  final String value;

  /// Depth is the quantity of descendants levels there are.
  /// If it has no children, it's 0; if it has many terminal children's 1;
  /// if it has at least one grandchildren, 2; etc...
  final int depth;
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
