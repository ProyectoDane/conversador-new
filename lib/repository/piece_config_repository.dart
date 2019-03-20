import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/circle.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/shape.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/color_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PieceConfigRepository {
  static var _instance = PieceConfigRepository._internal();

  factory PieceConfigRepository() => _instance;

  PieceConfigRepository._internal();

  // MARK: - Difficulties
  static final _DIFFICULTIES_KEY = "settings.difficulties";

  Future<bool> setPieceConfigAdditionals(final List<GameDifficulty> difficulties) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final difficultiesStrings = difficulties.map((difficulty) => difficulty.name).toList();
    return prefs.setStringList(_DIFFICULTIES_KEY, difficultiesStrings);
  }

  // MARK: - Set piece config parameters
  Future<bool> setPieceColorForConcept(int conceptId, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_COLOR_BY_CONCEPT_KEY(conceptId), colorToHex(color));
  }

  Future<bool> setPieceColorForPieceType(int pieceType, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_COLOR_BY_PIECE_KEY(pieceType), colorToHex(color));
  }

  Future<bool> setPieceAlphaForPieceType(int pieceType, double alpha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(_COLOR_BY_PIECE_KEY(pieceType), alpha);
  }

  Future<bool> setPieceShapeForConcept(int conceptId, int shapeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_SHAPE_BY_CONCEPT_KEY(conceptId), shapeId);
  }

  Future<PieceConfig> getPieceConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pieceConfig = _getDefaultConfig(prefs);
    final difficulties = prefs.getStringList(_DIFFICULTIES_KEY).map((difficultyName) => GameDifficulty.fromName(difficultyName)).toList();
    final pieceConfigWithDifficulties = PieceConfig.applyDifficulties(pieceConfig, difficulties);
    return Future.value(pieceConfigWithDifficulties);
  }

  // MARK: - Piece config values
  PieceConfig _getDefaultConfig(SharedPreferences prefs) {
    return PieceConfig(
      colorByConceptType: _getColorByConceptFrom(prefs),
      colorByPieceType: _getColorByPieceFrom(prefs),
      shapeByConceptType: _getShapeByConceptFrom(prefs),
    );
  }

  static final String Function(int) _COLOR_BY_CONCEPT_KEY = (conceptType) => "COLOR_BY_CONCEPT.$conceptType";

  Map<int, Color> Function() _getColorByConceptFrom(SharedPreferences prefs) {
    final String subjectColor = prefs.getString(_COLOR_BY_CONCEPT_KEY(Subject.TYPE));
    final String entityColor = prefs.getString(_COLOR_BY_CONCEPT_KEY(Entity.TYPE));
    final String predicateColor = prefs.getString(_COLOR_BY_CONCEPT_KEY(Predicate.TYPE));
    final String actionColor = prefs.getString(_COLOR_BY_CONCEPT_KEY(Action.TYPE));
    final String modifierColor = prefs.getString(_COLOR_BY_CONCEPT_KEY(Modifier.TYPE));
    final String complementColor = prefs.getString(_COLOR_BY_CONCEPT_KEY(Complement.TYPE));
    return () => {
      Subject.TYPE: subjectColor != null ? hexToColor(subjectColor) : Colors.green,
      Entity.TYPE: entityColor != null ? hexToColor(entityColor) : Colors.green,
      Predicate.TYPE: predicateColor != null ? hexToColor(predicateColor) : Colors.red,
      Action.TYPE: actionColor != null ? hexToColor(actionColor) : Colors.red,
      Modifier.TYPE: modifierColor != null ? hexToColor(modifierColor) : Colors.blue,
      Complement.TYPE: complementColor != null ? hexToColor(complementColor) : Colors.orange,
    };
  }

  static final String Function(int) _COLOR_BY_PIECE_KEY = (pieceType) => "COLOR_BY_PIECE.$pieceType";

  Map<int, Color> Function(Color) _getColorByPieceFrom(SharedPreferences prefs) {
    final dynamic targetInitial = prefs.get(_COLOR_BY_PIECE_KEY(Piece.TARGET_INITIAL));
    final dynamic targetCompleted = prefs.get(_COLOR_BY_PIECE_KEY(Piece.TARGET_COMPLETED));
    final dynamic dragInitial = prefs.get(_COLOR_BY_PIECE_KEY(Piece.DRAG_INITIAL));
    final dynamic dragFeedback = prefs.get(_COLOR_BY_PIECE_KEY(Piece.DRAG_FEEDBACK));
    final dynamic dragCompleted = prefs.get(_COLOR_BY_PIECE_KEY(Piece.DRAG_COMPLETED));

    final Color Function(Color) targetInitialFunction = _getDefaulted(targetInitial, Colors.black26, null);
    final Color Function(Color) targetCompletedFunction = _getDefaulted(targetCompleted, null, 1);
    final Color Function(Color) dragInitialFunction = _getDefaulted(dragInitial, null, 1);
    final Color Function(Color) dragFeedbackFunction = _getDefaulted(dragFeedback, null, 0.5);
    final Color Function(Color) dragCompletedFunction = _getDefaulted(dragCompleted, null, 0.5);

    return (Color color) => {
      Piece.TARGET_INITIAL: targetInitialFunction(color),
      Piece.TARGET_COMPLETED: targetCompletedFunction(color),
      Piece.DRAG_INITIAL: dragInitialFunction(color),
      Piece.DRAG_FEEDBACK: dragFeedbackFunction(color),
      Piece.DRAG_COMPLETED: dragCompletedFunction(color),
    };
  }

  Color Function(Color) _getDefaulted(dynamic value, Color defaultColor, double defaultOpacity) {
    if (value == null) {
      return (color) => defaultColor ?? color.withOpacity(defaultOpacity);
    }
    if (value is String) {
      return (color) => hexToColor(value);
    }
    return (color) => color.withOpacity(value as double);
  }

  static final String Function(int) _SHAPE_BY_CONCEPT_KEY = (conceptType) => "SHAPE_BY_CONCEPT.$conceptType";

  Map<int, Shape> Function(Color) _getShapeByConceptFrom(SharedPreferences prefs) {
    final int subjectId = prefs.get(_SHAPE_BY_CONCEPT_KEY(Subject.TYPE)) as int;
    final int entityId = prefs.get(_SHAPE_BY_CONCEPT_KEY(Entity.TYPE)) as int;
    final int predicateId = prefs.get(_SHAPE_BY_CONCEPT_KEY(Predicate.TYPE)) as int;
    final int actionId = prefs.get(_SHAPE_BY_CONCEPT_KEY(Action.TYPE)) as int;
    final int modifierId = prefs.get(_SHAPE_BY_CONCEPT_KEY(Modifier.TYPE)) as int;
    final int complementId = prefs.get(_SHAPE_BY_CONCEPT_KEY(Complement.TYPE)) as int;
    return (Color color) => {
      Subject.TYPE: Shape.fromID(subjectId ?? Rectangle.ID, color),
      Entity.TYPE: Shape.fromID(entityId ?? Rectangle.ID, color),
      Predicate.TYPE: Shape.fromID(predicateId ?? Circle.ID, color),
      Action.TYPE: Shape.fromID(actionId ?? Circle.ID, color),
      Modifier.TYPE: Shape.fromID(modifierId ?? Rectangle.ID, color),
      Complement.TYPE: Shape.fromID(complementId ?? Circle.ID, color),
    };
  }

}
