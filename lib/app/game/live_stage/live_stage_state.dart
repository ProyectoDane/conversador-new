import 'dart:math';

import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:meta/meta.dart';

/// State for LiveStageWidget. Stores:
/// - the drag pieces and their state,
/// - the target pieces that form the subject of the sentence,
/// - the target pieces that form the predicate of the sentence,
/// - the configuration for all pieces.
class LiveStageState {

  /// Creates a LiveStageState based on the information provided.
  LiveStageState(
      this.pieceConfig,
      this.dragPieces,
      this.subjectTargetPieces,
      this.predicateTargetPieces
      );

  /// Configuration for all pieces
  final PieceConfig pieceConfig;
  /// Drag pieces in the order they must be shown
  final List<DragPieceState> dragPieces;
  /// Target pieces that conform the subject, in the order they must be shown
  final List<TargetPieceState> subjectTargetPieces;
  /// Target pieces that conform the predicate, in the order they must be shown
  final List<TargetPieceState> predicateTargetPieces;

  /// Creates a new state based on the previous one, overwriting the state
  /// of the drag piece in the specified index
  LiveStageState changeDragPiece(int index, DragPieceState newPiece) {
    final List<DragPieceState> newDragPieces =
      List<DragPieceState>.from(dragPieces);
    newDragPieces[index] = newPiece;
    return LiveStageState(
      pieceConfig,
      newDragPieces,
      List<TargetPieceState>.from(subjectTargetPieces),
      List<TargetPieceState>.from(predicateTargetPieces)
    );
  }

  /// Creates a new state based on the previous one, overwriting the state
  /// of the subject target piece in the specified index
  LiveStageState changeSubjectTargetPiece(
    int index,
    TargetPieceState newPiece
  ) {
    final List<TargetPieceState> newSubjectTargetPieces =
      List<TargetPieceState>.from(subjectTargetPieces);
    newSubjectTargetPieces[index] = newPiece;
    return LiveStageState(
      pieceConfig,
      List<DragPieceState>.from(dragPieces),
      newSubjectTargetPieces,
      List<TargetPieceState>.from(predicateTargetPieces)
    );
  }

  /// Creates a new state based on the previous one, overwriting the state
  /// of the predicate target piece in the specified index
  /// (the index is taking into account only the predicate pieces)
  LiveStageState changePredicateTargetPiece(
    int index,
    TargetPieceState newPiece
  ) {
    final List<TargetPieceState> newPredicateTargetPieces =
      List<TargetPieceState>.from(predicateTargetPieces);
    newPredicateTargetPieces[index] = newPiece;
    return LiveStageState(
      pieceConfig,
      List<DragPieceState>.from(dragPieces),
      List<TargetPieceState>.from(subjectTargetPieces),
      newPredicateTargetPieces
    );
  }

  /// Getter for all the target pieces in order,
  /// despite if they are from subject or predicate
  List<TargetPieceState> get targetPieces =>
      subjectTargetPieces + predicateTargetPieces;

  /// Creates a new state based on the previous one, overwriting the state
  /// of the target piece in the specified index
  /// (the index takes into account the whole target pieces in the
  /// order respected in targetPieces getter).
  LiveStageState changeTargetPiece(int index, TargetPieceState newPiece) {
    final List<TargetPieceState> newSubjectTargetPieces =
      List<TargetPieceState>.from(subjectTargetPieces);
    final List<TargetPieceState> newPredicateTargetPieces =
      List<TargetPieceState>.from(predicateTargetPieces);
    if (index >= subjectTargetPieces.length) {
      final int predicateIndex = index - subjectTargetPieces.length;
      newPredicateTargetPieces[predicateIndex] = newPiece;
    } else {
      newSubjectTargetPieces[index] = newPiece;
    }
    return LiveStageState(
      pieceConfig,
      List<DragPieceState>.from(dragPieces),
      newSubjectTargetPieces,
      newPredicateTargetPieces
    );
  }

  /// True if all targets have been matched and have completed animating.
  bool get isCompleted => reduce(
    targetPieces,
    true,
    (bool allCompleted, TargetPieceState newTarget) =>
      allCompleted && newTarget.visualState == TargetPieceVisualState.animated
  );

}

/// State of a Drag Piece.
/// Represents which Piece it corresponds to,
/// and how many attempts are there left to use.
class DragPieceState {

  /// Created a state based on information provided.
  DragPieceState({@required this.piece, @required this.attemptsRemaining});

  /// Piece it represents
  final Piece piece;
  /// Quantity of attempts left for the user to match it correctly
  final int attemptsRemaining;

  /// Returns new state based on this one,
  /// but adding one more failed attempt
  /// (this doesn't change anything if there were no attempts left)
  DragPieceState failedAttempt() =>
    DragPieceState(
      piece: piece,
      attemptsRemaining: max(0, attemptsRemaining - 1)
    );

  /// Returns new state based on this one's piece,
  /// cancelling out all remaining attempts since it has been matched.
  DragPieceState success() =>
    DragPieceState(piece: piece, attemptsRemaining: 0);

  /// Whether the piece should be draggable (enabled) or not (disabled)
  bool get disabled => attemptsRemaining == 0;

}

/// Target piece's visual state
enum TargetPieceVisualState {
  /// State were the target piece is available for matching
  normal,
  /// State were the target is animating a warning or hint
  warning,
  /// State were the target has been matched and is animating it
  completed,
  /// State were the target has already been
  /// matched and has finished animating it
  animated
}

/// State of a targetPiece.
/// Represents which Piece it corresponds to,
/// and the visual state the target should reflect.
class TargetPieceState {

  /// Created a state based on provided information.
  /// The visualSatte has a default value: normal
  TargetPieceState({
    @required this.piece,
    this.visualState = TargetPieceVisualState.normal
  });

  /// Piece it corresponds to.
  final Piece piece;
  /// Visual state the piece should reflect
  final TargetPieceVisualState visualState;

  /// Returns new state based on this one,
  /// but setting the visual state to warning
  TargetPieceState shouldShowWarning() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.warning,
  );

  /// Returns new state based on this one,
  /// but setting the visual state to completed
  TargetPieceState shouldShowComplete() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.completed,
  );

  /// Returns new state based on this one,
  /// but setting the visual state to animated
  TargetPieceState completeHasAnimated() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.animated,
  );

  /// Returns new state based on this one,
  /// but setting the visual state to normal
  TargetPieceState backToNormal() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.normal,
  );

  /// If the target piece has been completed.
  /// This includes the completed and animated states.
  bool get completed =>
      visualState == TargetPieceVisualState.completed
          || visualState == TargetPieceVisualState.animated;

}