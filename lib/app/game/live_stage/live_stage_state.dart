import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:meta/meta.dart';

class LiveStageState {
  final ShapeConfig shapeConfig;
  final List<DragPieceState> dragPieces;
  final List<TargetPieceState> targetPieces;

  LiveStageState(this.shapeConfig, this.dragPieces, this.targetPieces);
  LiveStageState changeDragPiece(int index, DragPieceState newPiece) {
    List<DragPieceState> newDragPieces = List.from(dragPieces);
    newDragPieces[index] = newPiece;
    return LiveStageState(shapeConfig, newDragPieces, targetPieces);
  }
  LiveStageState changeTargetPiece(int index, TargetPieceState newPiece) {
    List<TargetPieceState> newTargetPieces = List.from(targetPieces);
    newTargetPieces[index] = newPiece;
    return LiveStageState(shapeConfig, dragPieces, newTargetPieces);
  }

  bool get isCompleted => reduce(
      targetPieces,
      true,
          (bool allCompleted, TargetPieceState newTarget) => allCompleted && newTarget.visualState == TargetPieceVisualState.animated
  );
}

class DragPieceState {
  final Piece piece;
  final int attemptsRemaining;

  DragPieceState({@required this.piece, @required this.attemptsRemaining});
  DragPieceState failedAttempt() {
    return DragPieceState(piece: piece, attemptsRemaining: attemptsRemaining == 0 ? 0 : attemptsRemaining - 1);
  }
  DragPieceState success() {
    return DragPieceState(piece: piece, attemptsRemaining: 0);
  }

  bool get disabled => attemptsRemaining == 0;

}

enum TargetPieceVisualState {
  normal, warning, completed, animated
}

class TargetPieceState {
  final Piece piece;
  final TargetPieceVisualState visualState;

  TargetPieceState({@required this.piece, this.visualState = TargetPieceVisualState.normal});
  TargetPieceState shouldShowWarning() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.warning,
  );
  TargetPieceState shouldShowComplete() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.completed,
  );
  TargetPieceState completeHasAnimated() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.animated,
  );
  TargetPieceState backToNormal() => TargetPieceState(
    piece: piece,
    visualState: TargetPieceVisualState.normal,
  );

  bool get completed => visualState == TargetPieceVisualState.completed || visualState == TargetPieceVisualState.animated;

}