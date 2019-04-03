import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

/// Event for LiveStageBloc
class LiveStageEvent {

  LiveStageEvent._internal(this.type, this.originPiece, this.targetPiece);

  /// Event for a failed attempt of dragging a piece.
  factory LiveStageEvent.failed(Piece dragPiece) => LiveStageEvent._internal(
      LiveStageEventType.pieceEndsIncorrectDragging,
      dragPiece,
      null
  );

  /// Event for a successful match between drag and target pieces.
  factory LiveStageEvent.success(
    Piece dragPiece,
    Piece targetPiece
  ) => LiveStageEvent._internal(
      LiveStageEventType.pieceDraggedToCorrectTarget,
      dragPiece,
      targetPiece
  );

  /// Event for when the targetPiece's warning animation finished.
  factory LiveStageEvent.endWarning(Piece targetPiece) =>
    LiveStageEvent._internal(
      LiveStageEventType.targetFinishedAnimatingWarning,
      null,
      targetPiece
  );

  /// Event for when the targetPiece's completion animation finished.
  factory LiveStageEvent.end(Piece targetPiece) =>
    LiveStageEvent._internal(
      LiveStageEventType.targetFinishedAnimatingCompletion,
      null,
      targetPiece
  );

  /// Type of event
  LiveStageEventType type;
  /// Drag piece involved in the event (if there is one)
  Piece originPiece;
  /// Target piece involved in the event (if there is one)
  Piece targetPiece;

}

/// Types of LiveStageEvent
enum LiveStageEventType {
  /// When a Drag piece is incorrectly dragged
  pieceEndsIncorrectDragging,
  /// When a Drag piece is correctly drag to a matching Target piece
  pieceDraggedToCorrectTarget,
  /// When the warning animation completed in a Target piece
  targetFinishedAnimatingWarning,
  /// When the completion animation completed in a Target piece
  targetFinishedAnimatingCompletion
}