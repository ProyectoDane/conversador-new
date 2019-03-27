import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:meta/meta.dart';

class LiveStageState {

  LiveStageState(
      this.pieceConfig,
      this.dragPieces,
      this.subjectTargetPieces,
      this.predicateTargetPieces
      );

  final PieceConfig pieceConfig;
  final List<DragPieceState> dragPieces;
  final List<TargetPieceState> subjectTargetPieces;
  final List<TargetPieceState> predicateTargetPieces;

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

  List<TargetPieceState> get targetPieces =>
      subjectTargetPieces + predicateTargetPieces;

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

  bool get isCompleted => reduce(
    subjectTargetPieces + predicateTargetPieces,
    true,
    (bool allCompleted, TargetPieceState newTarget) =>
      allCompleted && newTarget.visualState == TargetPieceVisualState.animated
  );

}

class DragPieceState {

  DragPieceState({@required this.piece, @required this.attemptsRemaining});

  final Piece piece;
  final int attemptsRemaining;

  DragPieceState failedAttempt() =>
    DragPieceState(
      piece: piece,
      attemptsRemaining: attemptsRemaining == 0 ? 0 : attemptsRemaining - 1
    );

  DragPieceState success() =>
    DragPieceState(piece: piece, attemptsRemaining: 0);

  bool get disabled => attemptsRemaining == 0;

}

enum TargetPieceVisualState {
  normal, warning, completed, animated
}

class TargetPieceState {

  TargetPieceState({
    @required this.piece,
    this.visualState = TargetPieceVisualState.normal
  });

  final Piece piece;
  final TargetPieceVisualState visualState;

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

  bool get completed =>
      visualState == TargetPieceVisualState.completed
          || visualState == TargetPieceVisualState.animated;

}