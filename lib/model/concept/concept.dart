abstract class Concept {
  static const int ID = 1;

  final List<Concept> concepts;
  final String value;
  final int type;

  Concept({this.value, this.concepts, this.type = ID});
}
