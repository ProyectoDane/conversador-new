import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';

abstract class GameDifficulty {
  PieceConfig apply(final PieceConfig pieceConfig);
  String get imageUri;
}
