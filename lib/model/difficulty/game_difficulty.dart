import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';

abstract class GameDifficulty {
  ShapeConfig apply(ShapeConfig shapeConfig);
}
