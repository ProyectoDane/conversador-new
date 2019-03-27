import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_event.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

class LiveStageBloc extends Bloc<LiveStageEvent, LiveStageState> {

  LiveStageBloc({
    @required this.subjectConcepts,
    @required this.predicateConcepts,
    @required this.pieceConfig,
    @required this.onCompleted,
    this.maxAttempts = 3,
    this.attemptsRemainingForWarning = 1
  }) :
        mixedConcepts = shuffled(subjectConcepts + predicateConcepts);

  final int maxAttempts;
  final int attemptsRemainingForWarning;
  final PieceConfig pieceConfig;
  final List<Concept> subjectConcepts;
  final List<Concept> predicateConcepts;
  final List<Concept> mixedConcepts;
  final Function() onCompleted;

  void pieceFailure(Piece dragPiece) {
    dispatch(LiveStageEvent.failed(dragPiece));
  }

  void pieceSuccess({@required Piece dragPiece, @required Piece targetPiece}) {
    dispatch(LiveStageEvent.success(dragPiece, targetPiece));
  }

  void completedWarningAnimation(Piece targetPiece) {
    dispatch(LiveStageEvent.endWarning(targetPiece));
  }
  
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
    LiveStageState currentState,
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