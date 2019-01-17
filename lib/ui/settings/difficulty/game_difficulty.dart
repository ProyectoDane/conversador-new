class GameDifficulty {
  static const int NO_SHAPES_AND_NO_COLORS = 0;
  static const int NO_SHAPES_AND_COLORS = 1;
  static const int SHAPES_AND_NO_COLORS = 2;
  static const int SHAPES_AND_COLORS = 3;

  final bool shapes;
  final bool colors;

  GameDifficulty({this.shapes = true, this.colors = true});

  int computeDiff() {
    final booleans = [shapes, colors];
    int result = 0;
    for (bool b in booleans) {
      result = (result << 1) | (b ? 1 : 0);
    }
    return result;
  }
}
