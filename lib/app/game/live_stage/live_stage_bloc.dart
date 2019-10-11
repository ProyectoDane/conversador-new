import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_event.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:flutter_syntactic_sorter/app/game/util/tts_manager.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

/// Bloc that handles a level inside a stage of the game.
/// It takes care of which concepts and pieces should be
/// show and what is their state. It also calls the completion
/// callback when the level is completed, i.e. when all pieces
/// have been drag to the correct places (or reached the maximum
/// attempts possible).
class LiveStageBloc extends Bloc<LiveStageEvent, LiveStageState> {

  /// Creates a LiveStageBloc from:
  /// - the subject and predicate concepts to show
  /// - the configuration of the pieces to show
  /// - completion callback to call when the level is completed
  /// - the maximum amount of attempts the user may have to get
  /// each piece correctly placed
  /// - the quantity of attempts that should remain for showing a
  /// warning to the user as a hint
  LiveStageBloc({
    @required this.subjectConcepts,
    @required this.predicateConcepts,
    @required this.pieceConfig,
    @required this.onCompleted,
    @required bool isShuffled,
    this.maxAttempts = 3,
    this.attemptsRemainingForWarning = 1
  }) :
        mixedConcepts = isShuffled ? 
                          shuffled(subjectConcepts + predicateConcepts):
                          subjectConcepts + predicateConcepts;

  /// Maximum attempts the user has to get each piece rightly placed
  final int maxAttempts;
  /// Number of attempts the user must have remaining to show a warning/hint
  final int attemptsRemainingForWarning;
  /// Configuration for the pieces that must be shown
  final PieceConfig pieceConfig;
  /// Subject concepts to be shown as pieces
  final List<Concept> subjectConcepts;
  /// Predicate concepts to be shown as pieces
  final List<Concept> predicateConcepts;
  /// All concepts mixed up, so the drag pieces appear shuffled
  final List<Concept> mixedConcepts;
  /// Completion callback for when level is completed
  final Function() onCompleted;

  /// Should be called when a drag piece is incorrectly placed
  void pieceFailure(Piece dragPiece) {
    dispatch(LiveStageEvent.failed(dragPiece));
  }

  /// Called when a drag piece is correctly placed in a target piece.
  void pieceSuccess({@required Piece dragPiece, @required Piece targetPiece}) {
    dispatch(LiveStageEvent.success(dragPiece, targetPiece));
  }

  /// Called when the warning/hint animation is completed on a target piece.
  void completedWarningAnimation(Piece targetPiece) {
    dispatch(LiveStageEvent.endWarning(targetPiece));
  }

  /// Called when the successfully completed animation
  /// is completed on a target piece.
  void completedSuccessAnimation(Piece targetPiece) {
    dispatch(LiveStageEvent.end(targetPiece));
  }

  @override
  LiveStageState get initialState {
    final List<Piece> subjectTargetPieces =
      enumerated(subjectConcepts).map((Tuple2<int, Concept> tuple) =>
        Piece(concept: tuple.item2, index: tuple.item1)
    ).toList();
    final List<Piece> predicateTargetPieces =
      enumerated(predicateConcepts).map((Tuple2<int, Concept> tuple) =>
        Piece(concept: tuple.item2, index: tuple.item1 + subjectConcepts.length)
    ).toList();

    final List<Piece> dragPieces =
      enumerated(mixedConcepts).map((Tuple2<int, Concept> tuple) =>
          Piece(concept: tuple.item2, index: tuple.item1)
    ).toList();
    final List<DragPieceState> dragStates =
      dragPieces.map((Piece piece) =>
          DragPieceState(piece: piece, attemptsRemaining: maxAttempts)
    ).toList();
    final List<TargetPieceState> subjectTargetStates =
      subjectTargetPieces.map((Piece piece) =>
          TargetPieceState(piece: piece)
    ).toList();
    final List<TargetPieceState> predicateTargetStates =
      predicateTargetPieces.map((Piece piece) =>
          TargetPieceState(piece: piece)
    ).toList();
    return LiveStageState(
      pieceConfig,
      dragStates,
      subjectTargetStates,
      predicateTargetStates,
    );
  }

  @override
  Stream<LiveStageState> mapEventToState(
    LiveStageEvent event
  ) async* {
    LiveStageState newState;
    switch (event.type) {
      case LiveStageEventType.pieceEndsIncorrectDragging:
        newState = _failureDrag(currentState, event.originPiece);
        break;
      case LiveStageEventType.pieceDraggedToCorrectTarget:
        newState = _successDrag(
            currentState,
            event.originPiece,
            event.targetPiece
        );
        break;
      case LiveStageEventType.targetFinishedAnimatingCompletion:
        newState = _completionAnimationEnded(currentState, event.targetPiece);
        break;
      case LiveStageEventType.targetFinishedAnimatingWarning:
        newState = _warningAnimationEnded(currentState, event.targetPiece);
        break;
    }

    if (newState != null) {
      yield newState;
      if (newState.isCompleted) {
        onCompleted();
      }
    }
  }

  LiveStageState _failureDrag(LiveStageState currentState, Piece draggedPiece) {
    final DragPieceState dragPiece =
      currentState.dragPieces[draggedPiece.index];
    if (!dragPiece.disabled) {
      final DragPieceState newDragPiece = dragPiece.failedAttempt();
      LiveStageState newState = currentState.changeDragPiece(
          draggedPiece.index,
          newDragPiece
      );
      final int remainingAttemptes = newDragPiece.attemptsRemaining;
      if (remainingAttemptes == 0) {
        TtsManager().playConcept(draggedPiece.concept);

        final TargetPieceState target =
          newState.targetPieces.firstWhere((TargetPieceState piece) =>
            piece.piece.concept.value == dragPiece.piece.concept.value
                && !piece.completed
        );
        newState = newState.changeTargetPiece(
            target.piece.index,
            target.shouldShowComplete()
        );
      } else if (remainingAttemptes == attemptsRemainingForWarning) {
        final List<TargetPieceState> possibleTargets =
          newState.targetPieces.where((TargetPieceState piece) =>
                piece.piece.concept.value == dragPiece.piece.concept.value
                    && !piece.completed
        ).toList();
        for (final TargetPieceState target in possibleTargets) {
          final TargetPieceState oldTarget =
            newState.targetPieces[target.piece.index];
          newState = newState.changeTargetPiece(
              oldTarget.piece.index,
              oldTarget.shouldShowWarning()
          );
        }
      }
      return newState;
    }
    return null;
  }

  LiveStageState _successDrag(
    LiveStageState currentState,
    Piece draggedPiece,
    Piece targetedPiece
  ) {
    // Reproduces word audio
    TtsManager().playConcept(draggedPiece.concept);

    final DragPieceState dragPiece =
      currentState.dragPieces[draggedPiece.index];
    final TargetPieceState targetPiece =
      currentState.targetPieces[targetedPiece.index];
    if (!dragPiece.disabled && !targetPiece.completed
        && dragPiece.piece.concept.value == targetPiece.piece.concept.value) {
      final LiveStageState newState = currentState.changeDragPiece(
          dragPiece.piece.index,
          dragPiece.success()
      );
      return newState.changeTargetPiece(
          targetPiece.piece.index,
          targetPiece.shouldShowComplete()
      );
    }
    return null;
  }

  LiveStageState _completionAnimationEnded(
    LiveStageState currentState,
    Piece targetPiece
  ) {
    final TargetPieceState target =
      currentState.targetPieces[targetPiece.index];
    if (target.visualState == TargetPieceVisualState.completed) {
      final TargetPieceState finalTarget = target.completeHasAnimated();
      return currentState.changeTargetPiece(target.piece.index, finalTarget);
    }
    return null;
  }

  LiveStageState _warningAnimationEnded(
    LiveStageState currentState,
    Piece targetPiece
  ) {
    final TargetPieceState target =
      currentState.targetPieces[targetPiece.index];
    if (target.visualState == TargetPieceVisualState.warning) {
      final TargetPieceState finalTarget = target.backToNormal();
      return currentState.changeTargetPiece(target.piece.index, finalTarget);
    }
    return null;
  }

}