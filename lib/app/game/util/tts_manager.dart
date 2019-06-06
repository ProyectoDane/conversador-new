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

    // This is a work around for spanish, for single letter words 
    // like "a","e","o","y"
    String text;
    final bool isSpanish = LangLocalizations.localeString.contains('es');
    if (concept.value.length == 1 && isSpanish) {
      text = 'h${concept.value}';
    } else {
      text = concept.value;
    }
    
    await _flutterTts.speak(text);
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
      return Tuple2<String, int>(
        concept.value, estimatedWordDuration);
    } else {
      final int total = estimatedWordDuration * concept.children.length;
      return Tuple2<String, int>(
        concept.value, total);
    }
  }

  Future<void> _setLanguage() async {
    final String language = LangLocalizations.localeString;
    await _flutterTts.setLanguage(language);

    _isLanguageSet = true;
  }
}