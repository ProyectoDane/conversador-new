abstract class Concept {
  final List<Concept> children;
  final String value;
  final int type;

  Concept({this.value, this.children, this.type});
}
