import 'dart:math';

import 'package:meta/meta.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';

abstract class Concept {
  final List<Concept> children;
  final String value;
  /// Depth is the quantity of descendants levels there are.
  /// If it has no children, it's 0; if it has many terminal children's 1;
  /// if it has at least one grandchildren, 2; etc...
  final int depth;
  final int type;

  Concept.intermediate({@required this.children, @required this.type})
      : this.value = _reduceChildren(children),
        this.depth = _getChildrenDepth(children);

  Concept.terminal({@required this.value, @required this.type})
      : this.children = [],
        this.depth = 0;

  bool operator ==(dynamic other) => other is Concept && value == other.value && type == other.type;

  int get hashCode => value.hashCode^type.hashCode;
}

String _reduceChildren(List<Concept> children) {
  if (children.isEmpty) return '';

  String result = reduce(
      children,
      '',
          (phrase, Concept concept) => phrase + ' ' + concept.value
  );
  return result.trim();
}

int _getChildrenDepth(List<Concept> children) {
  if (children.isEmpty) return 0;

  int childrenDepth = reduce(
      children,
      0,
          (maxDepth, Concept concept) => max(maxDepth, concept.depth)
  );
  return childrenDepth + 1;
}