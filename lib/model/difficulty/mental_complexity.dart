import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';

/// Complexity values
enum Complexity {
  /// Invalid value. This is used because the complexity data in the Data Base
  /// starts at 1, not 0. Without this extra value, the db parser would fail.
  invalid,
  /// Easy
  easy,
  /// Normal
  normal,
  /// Hard
  hard,
  /// Expert
  expert
}

/// Mental complexity of the stage the user
/// will try to resolve
class MentalComplexity {
  /// Creates a MentalComplexity with a name.
  MentalComplexity({this.id, this.description});

  static final Map<Complexity,String> _textMap = <Complexity,String>{
    Complexity.easy: 'game_difficulty_easy',
    Complexity.normal: 'game_difficulty_normal',
    Complexity.hard: 'game_difficulty_hard',
    Complexity.expert: 'game_difficulty_expert'
  };

  /// Returns complexity in text form
  static String getComplexityText(int compl, BuildContext context){
    final String key = _textMap[compl];
    final String localizedText = LangLocalizations.of(context).trans(key);

    return localizedText;
  }

  /// Id of the mental complexity
  int id;

  /// Description of the mental complexity
  String description;
}
