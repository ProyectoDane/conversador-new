import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:meta/meta.dart';

class Stage {
  final int value;
  final int maxDifficulty;
  final String backgroundUri;
  final List<Level> levels;

  Stage({@required this.value, @required this.maxDifficulty, @required this.backgroundUri, @required this.levels});
}
