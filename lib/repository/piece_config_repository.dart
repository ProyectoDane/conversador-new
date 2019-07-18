import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/color_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/shape_painter.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/circle_painter.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/rectangle_painter.dart';
import 'package:flutter_syntactic_sorter/model/figure/painter/diamond_painter.dart';

/// Repository for getting and setting
/// the piece configuration.
class PieceConfigRepository {

  /// Returns a repository
  factory PieceConfigRepository() => _instance;

  PieceConfigRepository._internal();

  static final PieceConfigRepository _instance =
    PieceConfigRepository._internal();

  // MARK: - Difficulties
  static const String _DIFFICULTIES_KEY = 'settings.difficulties';

  /// Add difficulties to default configuration
  Future<bool> setPieceConfigAdditionals(
      final List<GameModeDifficulty> difficulties
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> difficultiesStrings = difficulties
        .map((GameModeDifficulty difficulty) => difficulty.name)
        .toList();
    return prefs.setStringList(_DIFFICULTIES_KEY, difficultiesStrings);
  }

  // MARK: - Set piece config parameters
  /// Change the color corresponding to the concept with that id
  Future<bool> setPieceColorForConcept(int conceptId, Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_COLOR_BY_CONCEPT_KEY(conceptId), colorToHex(color));
  }

  /// Change the final color it should use for the piece type specified
  Future<bool> setPieceColorForPieceType(int pieceType, Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_COLOR_BY_PIECE_KEY(pieceType), colorToHex(color));
  }

  /// Change the alpha to be applied to the concept color,
  /// for the specified piece type.
  Future<bool> setPieceAlphaForPieceType(int pieceType, double alpha) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(_COLOR_BY_PIECE_KEY(pieceType), alpha);
  }

  /// Change the shape to be used for the concept with the specified id.
  Future<bool> setPieceShapeForConcept(int conceptId, int shapeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_SHAPE_BY_CONCEPT_KEY(conceptId), shapeId);
  }

  // MARK: - Get piece config
  /// Get the configured piece configuration
  Future<PieceConfig> getPieceConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final PieceConfig pieceConfig = _getDefaultConfig(prefs);
    final List<GameModeDifficulty> difficulties = prefs
        .getStringList(_DIFFICULTIES_KEY)
        .map(GameModeDifficulty.fromName)
        .toList();
    final PieceConfig pieceConfigWithDifficulties =
      PieceConfig.applyDifficulties(pieceConfig, difficulties);
    return Future<PieceConfig>.value(pieceConfigWithDifficulties);
  }

  // MARK: - Piece config values
  PieceConfig _getDefaultConfig(SharedPreferences prefs) =>
    PieceConfig(
      colorByConceptType: _getColorByConceptFrom(prefs),
      colorByPieceType: _getColorByPieceFrom(prefs),
      painterByConceptType: _getPainterByConceptFrom(prefs),
    );

  // ignore: prefer_function_declarations_over_variables, non_constant_identifier_names
  static final String Function(int) _COLOR_BY_CONCEPT_KEY =
      (int conceptType) => 'COLOR_BY_CONCEPT.$conceptType';

  Map<int, Color> Function() _getColorByConceptFrom(SharedPreferences prefs) {
    final String subjectColor = prefs
        .getString(_COLOR_BY_CONCEPT_KEY(Subject.TYPE));
    final String entityColor = prefs
        .getString(_COLOR_BY_CONCEPT_KEY(Entity.TYPE));
    final String predicateColor = prefs
        .getString(_COLOR_BY_CONCEPT_KEY(Predicate.TYPE));
    final String actionColor = prefs
        .getString(_COLOR_BY_CONCEPT_KEY(ActionVerb.TYPE));
    final String modifierColor = prefs
        .getString(_COLOR_BY_CONCEPT_KEY(Modifier.TYPE));
    final String complementColor = prefs
        .getString(_COLOR_BY_CONCEPT_KEY(Complement.TYPE));
    return () => <int, Color>{
      Subject.TYPE: subjectColor != null
          ? hexToColor(subjectColor)
          : Colors.green,
      Entity.TYPE: entityColor != null
          ? hexToColor(entityColor)
          : Colors.green,
      Predicate.TYPE: predicateColor != null
          ? hexToColor(predicateColor)
          : Colors.red,
      ActionVerb.TYPE: actionColor != null
          ? hexToColor(actionColor)
          : Colors.red,
      Modifier.TYPE: modifierColor != null
          ? hexToColor(modifierColor)
          : Colors.blue,
      Complement.TYPE: complementColor != null
          ? hexToColor(complementColor)
          : Colors.orange,
    };
  }

  // ignore: prefer_function_declarations_over_variables, non_constant_identifier_names
  static final String Function(int) _COLOR_BY_PIECE_KEY =
      (int pieceType) => 'COLOR_BY_PIECE.$pieceType';

  Map<int, Color> Function(Color) _getColorByPieceFrom(
      SharedPreferences prefs
  ) {
    final dynamic targetInitial = prefs
        .get(_COLOR_BY_PIECE_KEY(Piece.TARGET_INITIAL));
    final dynamic targetCompleted = prefs
        .get(_COLOR_BY_PIECE_KEY(Piece.TARGET_COMPLETED));
    final dynamic dragInitial = prefs
        .get(_COLOR_BY_PIECE_KEY(Piece.DRAG_INITIAL));
    final dynamic dragFeedback = prefs
        .get(_COLOR_BY_PIECE_KEY(Piece.DRAG_FEEDBACK));
    final dynamic dragCompleted = prefs
        .get(_COLOR_BY_PIECE_KEY(Piece.DRAG_COMPLETED));

    final Color Function(Color) targetInitialFunction = _getDefaulted(
        targetInitial,
        Colors.black26,
        null
    );
    final Color Function(Color) targetCompletedFunction = _getDefaulted(
        targetCompleted,
        null,
        1
    );
    final Color Function(Color) dragInitialFunction = _getDefaulted(
        dragInitial,
        null,
        1
    );
    final Color Function(Color) dragFeedbackFunction = _getDefaulted(
        dragFeedback,
        null,
        0.5
    );
    final Color Function(Color) dragCompletedFunction = _getDefaulted(
        dragCompleted,
        null,
        0.5
    );

    return (Color color) => <int, Color>{
      Piece.TARGET_INITIAL: targetInitialFunction(color),
      Piece.TARGET_COMPLETED: targetCompletedFunction(color),
      Piece.DRAG_INITIAL: dragInitialFunction(color),
      Piece.DRAG_FEEDBACK: dragFeedbackFunction(color),
      Piece.DRAG_COMPLETED: dragCompletedFunction(color),
    };
  }

  Color Function(Color) _getDefaulted(
      dynamic value,
      Color defaultColor,
      double defaultOpacity
  ) {
    if (value == null) {
      return (Color color) => defaultColor ?? color.withOpacity(defaultOpacity);
    }
    if (value is String) {
      return (Color color) => hexToColor(value);
    }
    // ignore: avoid_as
    return (Color color) => color.withOpacity(value as double);
  }

  // ignore: prefer_function_declarations_over_variables, non_constant_identifier_names
  static final String Function(int) _SHAPE_BY_CONCEPT_KEY =
      (int conceptType) => 'SHAPE_BY_CONCEPT.$conceptType';

  Map<int, ShapePainter> Function(Color) _getPainterByConceptFrom(
      SharedPreferences prefs
  ) {
    final int subjectId = prefs.getInt(_SHAPE_BY_CONCEPT_KEY(Subject.TYPE));
    final int entityId = prefs.getInt(_SHAPE_BY_CONCEPT_KEY(Entity.TYPE));
    final int predicateId = prefs.getInt(_SHAPE_BY_CONCEPT_KEY(Predicate.TYPE));
    final int actionId = prefs.getInt(_SHAPE_BY_CONCEPT_KEY(ActionVerb.TYPE));
    final int modifierId = prefs.getInt(_SHAPE_BY_CONCEPT_KEY(Modifier.TYPE));
    final int complementId = prefs
        .getInt(_SHAPE_BY_CONCEPT_KEY(Complement.TYPE));
    return (Color color) => <int, ShapePainter>{
      Subject.TYPE: ShapePainter.fromID(
        subjectId ?? RectanglePainter.ID, color),
      Entity.TYPE: ShapePainter.fromID(
        entityId ?? RectanglePainter.ID, color),
      Predicate.TYPE: ShapePainter.fromID(
        predicateId ?? CirclePainter.ID, color),
      ActionVerb.TYPE: ShapePainter.fromID(
        actionId ?? CirclePainter.ID, color),
      Modifier.TYPE: ShapePainter.fromID(
        modifierId ?? RectanglePainter.ID, color),
      Complement.TYPE: ShapePainter.fromID(
        complementId ?? DiamondPainter.ID, color),
    };
  }

}
