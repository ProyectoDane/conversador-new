import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:tuple/tuple.dart';

/// This class handles the Text to Speech functionality
class TtsManager {
  /// Returns a Singleton
  factory TtsManager() => _instance;
  TtsManager._internal() {
    _flutterTts.setSpeechRate(0.5);
  }
  static final TtsManager _instance = TtsManager._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isLanguageSet = false;

  /// Reproduces a single word
  Future<void> playConcept(Concept concept) async {
    if (!_isLanguageSet) {
      await _setLanguage();
    }
    
    await _flutterTts.speak(concept.value);
  }

  /// Reproduces the entire sentence and returns duration in miliseconds
  Future<Duration> playSentence(
    Sentence sentence) async {
    if (!_isLanguageSet) {
      await _setLanguage();
    }

    final Tuple2<String, int> subjectTup = _getContentFromConcept(
      sentence.subject);
    final Tuple2<String, int> predicateTup = _getContentFromConcept(
      sentence.predicate);

    final String subjectStr = subjectTup.item1;
    final String predicateStr = predicateTup.item1;
    final String sentenceString = '$subjectStr $predicateStr';
    await _flutterTts.speak(sentenceString);

    return Duration(milliseconds: subjectTup.item2 + predicateTup.item2);
  }

  Tuple2<String, int> _getContentFromConcept(Concept concept) {
    const int estimatedWordDuration = 600;//miliseconds

    if (concept.children.isEmpty) {
      return Tuple2<String, int>(concept.value, estimatedWordDuration);
    } else {
      final int total = estimatedWordDuration * concept.children.length;
      return Tuple2<String, int>(concept.value, total);
    }
  }

  Future<void> _setLanguage() async {
    final String language = LangLocalizations.localeString;
    await _flutterTts.setLanguage(language);

    _isLanguageSet = true;
  }
}