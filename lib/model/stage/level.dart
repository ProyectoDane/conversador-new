import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:meta/meta.dart';

class Level {
  final List<Stage> stages;
  final int number;

  Level({@required this.stages, @required this.number});
}
