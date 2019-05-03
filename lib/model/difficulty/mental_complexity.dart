import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';

/// Mental complexity of the stage the user
/// will try to resolve
class MentalComplexity {
  /// Creates a MentalComplexity with a name.
  MentalComplexity({this.id, this.description});

  /// Easy
  static int mentalComplexityEasy = 1;
  /// Normal
  static int mentalComplexityNormal = 2;
  /// Hard
  static int mentalComplexityHard = 3;
  /// Expert
  static int mentalComplexityExpert = 4;

  static final Map<int,String> _textMap = <int,String>{
    mentalComplexityEasy: 'game_difficulty_easy',
    mentalComplexityNormal: 'game_difficulty_normal',
    mentalComplexityHard: 'game_difficulty_hard',
    mentalComplexityExpert: 'game_difficulty_expert'
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
