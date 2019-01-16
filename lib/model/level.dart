import 'package:flutter_syntactic_sorter/model/sentence.dart';
import 'package:meta/meta.dart';

class Level {
  final int value;
  final int maxDifficulty;
  final String backgroundUri;
  final List<Sentence> sentences;

  Level({@required this.value, @required this.maxDifficulty, @required this.backgroundUri, @required this.sentences});
}
