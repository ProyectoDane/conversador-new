import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class LiveStageEvent {
  LiveStageEventType type;
  Piece originPiece;
  Piece targetPiece;

  LiveStageEvent(this.type, this.originPiece, this.targetPiece);

  factory LiveStageEvent.failed(Piece dragPiece) => LiveStageEvent(
      LiveStageEventType.pieceEndsIncorrectDragging,
      dragPiece,
      null
  );
  factory LiveStageEvent.success(Piece dragPiece, Piece targetPiece) => LiveStageEvent(
      LiveStageEventType.pieceDraggedToCorrectTarget,
      dragPiece,
      targetPiece
  );
  factory LiveStageEvent.endWarning(Piece targetPiece) => LiveStageEvent(
      LiveStageEventType.targetFinishedAnimatingWarning,
      null,
      targetPiece
  );
  factory LiveStageEvent.end(Piece targetPiece) => LiveStageEvent(
      LiveStageEventType.targetFinishedAnimatingCompletion,
      null,
      targetPiece
  );
}

enum LiveStageEventType {
  pieceEndsIncorrectDragging,
  pieceDraggedToCorrectTarget,
  targetFinishedAnimatingWarning,
  targetFinishedAnimatingCompletion
}