abstract class Concept {
  final List<Concept> children;
  final String value;
  final int type;

  Concept({this.value, this.children, this.type});

  bool operator ==(other) => other is Concept && value == other.value && type == other.type;

  int get hashCode => value.hashCode^type.hashCode;
}
