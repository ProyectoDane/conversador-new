import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:meta/meta.dart';

class LiveStageState {
  final PieceConfig pieceConfig;
  final List<DragPieceState> dragPieces;
  final List<TargetPieceState> subjectTargetPieces;
  final List<TargetPieceState> predicateTargetPieces;

  LiveStageState(
    this.pieceConfig,
    this.dragPieces,
    this.subjectTargetPieces,
    this.predicateTargetPieces
  );

  LiveStageState changeDragPiece(int index, DragPieceState newPiece) {
    List<DragPieceState> newDragPieces = List.from(dragPieces);
    newDragPieces[index] = newPiece;
    return LiveStageState(
      pieceConfig,
      newDragPieces,
      List.from(subjectTargetPieces),
      List.from(predicateTargetPieces)
    );
  }
  LiveStageState changeSubjectTargetPiece(int index, TargetPieceState newPiece) {
    List<TargetPieceState> newSubjectTargetPieces = List.from(subjectTargetPieces);
    newSubjectTargetPieces[index] = newPiece;
    return LiveStageState(
      pieceConfig,
      List.from(dragPieces),
      newSubjectTargetPieces,
      List.from(predicateTargetPieces)
    );
  }
  LiveStageState changePredicateTargetPiece(int index, TargetPieceState newPiece) {
    List<TargetPieceState> newPredicateTargetPieces = List.from(predicateTargetPieces);
    newPredicateTargetPieces[index] = newPiece;
    return LiveStageState(
      pieceConfig,
      List.from(dragPieces),
      List.from(subjectTargetPieces),
      newPredicateTargetPieces
    );
  }

  List<TargetPieceState> get targetPieces => subjectTargetPieces + predicateTargetPieces;

  LiveStageState changeTargetPiece(int index, TargetPieceState newPiece) {
    List<TargetPieceState> newSubjectTargetPieces = List.from(subjectTargetPieces);
    List<TargetPieceState> newPredicateTargetPieces = List.from(predicateTargetPieces);
    if (index >= subjectTargetPieces.length) {
      final predicateIndex = index - subjectTargetPieces.length;
      newPredicateTargetPieces[predicateIndex] = newPiece;
    } else {
      newSubjectTargetPieces[index] = newPiece;
    }
    return LiveStageState(
      pieceConfig,
      List.from(dragPieces),
      newSubjectTargetPieces,
      newPredicateTargetPieces
    );
  }

  bool get isCompleted => reduce(
      subjectTargetPieces + predicateTargetPieces,
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