import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_event.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:meta/meta.dart';

class LiveStageBloc extends Bloc<LiveStageEvent, LiveStageState> {
  final int maxAttempts;
  final int attemptsRemainingForWarning;
  final ShapeConfig shapeConfig;
  final List<Concept> concepts;
  final List<Concept> mixedConcepts;
  final Function() onCompleted;

  LiveStageBloc({@required this.concepts,
    @required this.shapeConfig,
    @required this.onCompleted,
    this.maxAttempts = 3,
    this.attemptsRemainingForWarning = 1}) :
    this.mixedConcepts = shuffled(concepts);

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
    final List<Piece> targetPieces = enumerated(this.concepts).map((tuple) =>
        Piece(concept: tuple.item2, index: tuple.item1)
    ).toList();

    final List<Piece> dragPieces = enumerated(this.mixedConcepts).map((tuple) => Piece(concept: tuple.item2, index: tuple.item1)).toList();
    final List<DragPieceState> dragStates = dragPieces.map((piece) => DragPieceState(piece: piece, attemptsRemaining: maxAttempts)).toList();
    final List<TargetPieceState> targetStates = targetPieces.map((piece) => TargetPieceState(piece: piece)).toList();
    return LiveStageState(
      shapeConfig,
      dragStates,
      targetStates,
    );
  }

  @override
  Stream<LiveStageState> mapEventToState(LiveStageState currentState, LiveStageEvent event) async* {
    LiveStageState newState;
    switch (event.type) {
      case LiveStageEventType.pieceEndsIncorrectDragging:
        newState = _failureDrag(currentState, event.originPiece);
        break;
      case LiveStageEventType.pieceDraggedToCorrectTarget:
        newState = _successDrag(currentState, event.originPiece, event.targetPiece);
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
    final dragPiece = currentState.dragPieces[draggedPiece.index];
    if (!dragPiece.disabled) {
      final newDragPiece = dragPiece.failedAttempt();
      LiveStageState newState = currentState.changeDragPiece(draggedPiece.index, newDragPiece);
      if (newDragPiece.attemptsRemaining == 0) {
        final target = newState.targetPieces.firstWhere((piece){
          return piece.piece.concept.value == dragPiece.piece.concept.value && !piece.completed;
        });
        newState = newState.changeTargetPiece(target.piece.index, target.shouldShowComplete());
      } else if (newDragPiece.attemptsRemaining == attemptsRemainingForWarning) {
        final possibleTargets = newState.targetPieces.where((piece) => piece.piece.concept.value == dragPiece.piece.concept.value && !piece.completed);
        for (var target in possibleTargets) {
          final oldTarget = newState.targetPieces[target.piece.index];
          newState = newState.changeTargetPiece(oldTarget.piece.index, oldTarget.shouldShowWarning());
        }
      }
      return newState;
    }
    return null;
  }

  LiveStageState _successDrag(LiveStageState currentState, Piece draggedPiece, Piece targetedPiece) {
    final dragPiece = currentState.dragPieces[draggedPiece.index];
    final targetPiece = currentState.targetPieces[targetedPiece.index];
    if (!dragPiece.disabled && !targetPiece.completed
        && dragPiece.piece.concept.value == targetPiece.piece.concept.value) {
      LiveStageState newState = currentState.changeDragPiece(dragPiece.piece.index, dragPiece.success());
      newState = newState.changeTargetPiece(targetPiece.piece.index, targetPiece.shouldShowComplete());
      return newState;
    }
    return null;
  }

  LiveStageState _completionAnimationEnded(LiveStageState currentState, Piece targetPiece) {
    final target = currentState.targetPieces[targetPiece.index];
    if (target.visualState == TargetPieceVisualState.completed) {
      final finalTarget = target.completeHasAnimated();
      return currentState.changeTargetPiece(target.piece.index, finalTarget);
    }
    return null;
  }

  LiveStageState _warningAnimationEnded(LiveStageState currentState, Piece targetPiece) {
    final target = currentState.targetPieces[targetPiece.index];
    if (target.visualState == TargetPieceVisualState.warning) {
      final finalTarget = target.backToNormal();
      return currentState.changeTargetPiece(target.piece.index, finalTarget);
    }
    return null;
  }

}