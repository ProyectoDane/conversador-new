import 'package:flutter_syntactic_sorter/model/piece/piece.dart';

class LiveStageEvent {

  LiveStageEvent._internal(this.type, this.originPiece, this.targetPiece);

  factory LiveStageEvent.failed(Piece dragPiece) => LiveStageEvent._internal(
      LiveStageEventType.pieceEndsIncorrectDragging,
      dragPiece,
      null
  );

  factory LiveStageEvent.success(
    Piece dragPiece,
    Piece targetPiece
  ) => LiveStageEvent._internal(
      LiveStageEventType.pieceDraggedToCorrectTarget,
      dragPiece,
      targetPiece
  );

  factory LiveStageEvent.endWarning(Piece targetPiece) =>
    LiveStageEvent._internal(
      LiveStageEventType.targetFinishedAnimatingWarning,
      null,
      targetPiece
  );

  factory LiveStageEvent.end(Piece targetPiece) =>
    LiveStageEvent._internal(
      LiveStageEventType.targetFinishedAnimatingCompletion,
      null,
      targetPiece
  );


  LiveStageEventType type;
  Piece originPiece;
  Piece targetPiece;

}

enum LiveStageEventType {
  pieceEndsIncorrectDragging,
  pieceDraggedToCorrectTarget,
  targetFinishedAnimatingWarning,
  targetFinishedAnimatingCompletion
}