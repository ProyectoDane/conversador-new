import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_event.dart';
import 'package:flutter_syntactic_sorter/app/game/util/positions_helper.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/figure/shape/rectangle.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/drag_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/target_piece.dart';
import 'package:flutter_syntactic_sorter/util/list_extensions.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:tuple/tuple.dart';

/// Widget for LiveStage.
/// It places the pieces and configures them as expected,
/// as well as the subject and predicate containing boxes.
/// It also handles:
/// - the dragging
/// - the animations (after an incorrect drag or a match and the warnings)
/// - the sounds (success or failure)
class LiveStageWidget extends StatefulWidget {
  /// Creates a LiveStageWidget from a LiveStageBloc
  const LiveStageWidget(this.bloc);

  /// The LiveStageBloc associated
  final LiveStageBloc bloc;

  @override
  State createState() => _LiveStageState();

}

class _LiveStageState extends State<LiveStageWidget> {

  @override
  Widget build(BuildContext context) =>
    BlocBuilder<LiveStageEvent, LiveStageState>(
      bloc: widget.bloc,
      builder: (BuildContext context, LiveStageState state) => _render(state),
    );

  Widget _render(final LiveStageState state) =>
    Stack(children: _buildDraggableAndTargets(
        context,
        state.dragPieces,
        state.subjectTargetPieces,
        state.predicateTargetPieces,
        state.pieceConfig
      ),
    );

  List<Widget> _buildDraggableAndTargets(
      final BuildContext context,
      final List<DragPieceState> draggables,
      final List<TargetPieceState> subjectTargets,
      final List<TargetPieceState> predicateTargets,
      final PieceConfig pieceConfig) {
    final List<Widget> targetPieces = _buildTargetPieces(
      context: context,
      subjectTargets: subjectTargets,
      predicateTargets: predicateTargets,
      pieceConfig: pieceConfig,
    );
    final List<Widget> dragPieces = _buildPieces(
      context: context,
      elements: draggables,
      atTheTop: true,
      getWidget: (DragPieceState drag, Offset offset) =>
        DragPiece(piece: drag.piece,
          pieceConfig: pieceConfig,
          initPosition: offset,
          disabled: drag.disabled,
        ),
    );
    return List<Widget>.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces<E>({
    @required final BuildContext context,
    @required final List<E> elements,
    @required final bool atTheTop,
    @required Widget Function(E, Offset) getWidget
  }) {
    final List<double> positions = PositionHelper.generateEquidistantXPositions(
        context,
        elements.length
    );
    final double yPosition = PositionHelper.generateEquidistantYPosition(
        context,
        atTheTop
    );
    return zip(elements, positions).map((Tuple2<E, double> tuple){
      final E element = tuple.item1;
      final double xPosition = tuple.item2;
      final Offset offset = Offset(xPosition, yPosition);
      return getWidget(element, offset);
    }).toList();
  }

  List<Widget> _buildTargetPieces({
    @required final BuildContext context,
    @required final List<TargetPieceState> predicateTargets,
    @required final List<TargetPieceState> subjectTargets,
    @required final PieceConfig pieceConfig,
  }) {
    final List<TargetPieceState> targets = subjectTargets + predicateTargets;
    final List<double> positions = PositionHelper.generateEquidistantXPositions(
        context,
        targets.length
    );
    final double yPosition = PositionHelper.generateEquidistantYPosition(
        context,
        false
    );
    final double piecesSeparation =
        positions[1] - (positions[0] + Piece.BASE_SIZE);
    final Color subjectColor = pieceConfig.colorByConceptType()[Subject.TYPE];
    final Color predicateColor =
      pieceConfig.colorByConceptType()[Predicate.TYPE];
    final List<Widget> widgets = <Widget>[];
    addTargets(
        widgets,
        positions,
        subjectTargets,
        yPosition,
        pieceConfig,
        0,
        subjectColor.withAlpha(60),
        piecesSeparation
    );
    addTargets(
        widgets,
        positions,
        predicateTargets,
        yPosition,
        pieceConfig,
        1,
        predicateColor.withAlpha(60),
        piecesSeparation
    );
    return widgets;
  }

  void addTargets(
    List<Widget> widgets,
    List<double> positions,
      List<TargetPieceState> targets,
      double yPosition,
      PieceConfig pieceConfig,
      int boxIndex,
      Color boxColor,
      double piecesSeparation
  ) {
    final double initialX = positions[0];
    double finalX = initialX;
    for (final TargetPieceState target in targets) {
      final double xPosition = positions.removeAt(0);
      final Offset offset = Offset(xPosition, yPosition);
      widgets.add(TargetPiece(
          piece: target.piece,
          pieceConfig: pieceConfig,
          initPosition: offset,
          visualState: target.visualState,
          bloc: widget.bloc
      ));
      finalX = xPosition;
    }
    ShapeDecoration(shape: RoundedRectangleBorder());
    final double border = min(piecesSeparation/3, Piece.BASE_SIZE / 4);
    final Widget box = Positioned(
        left: initialX - border,
        top: yPosition - border,
        child: Container(
          width: (finalX + Piece.BASE_SIZE + border) - (initialX - border),
          height: Piece.BASE_SIZE + border * 2,
          decoration: Rectangle(color: boxColor, borderColor: Colors.black),
        )
    );
    widgets.insert(boxIndex, box);
  }

}