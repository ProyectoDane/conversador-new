import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_event.dart';
import 'package:flutter_syntactic_sorter/app/game/util/positions_helper.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/drag_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/target_piece.dart';

class LiveStageWidget extends StatefulWidget {
  final LiveStageBloc bloc;
  LiveStageWidget(this.bloc);

  @override
  State createState() => _LiveStageState();

}

class _LiveStageState extends State<LiveStageWidget> {
  Widget _toRender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveStageEvent, LiveStageState>(
      bloc: widget.bloc,
      builder: (BuildContext context, LiveStageState state) => _render(state),
    );
  }

  Widget _render(final LiveStageState state) {
    _toRender = SafeArea(
      child: Builder(builder: (context) {
        return Stack(children: _buildDraggableAndTargets(
        context,
        state.dragPieces,
        state.targetPieces,
            state.shapeConfig));
      }),
    );
    return _toRender;
  }

  List<Widget> _buildDraggableAndTargets(
      final BuildContext context,
      final List<DragPieceState> draggables,
      final List<TargetPieceState> targets,
      final ShapeConfig shapeConfig) {
    final targetPieces = _buildPieces(
        context: context,
        elements: targets,
        atTheTop: false,
        getWidget: (TargetPieceState target, Offset offset){
          return TargetPiece(piece: target.piece,
              shapeConfig: shapeConfig,
              initPosition: offset,
              visualState: target.visualState,
              bloc: widget.bloc);
        },
    );
    final dragPieces = _buildPieces(
      context: context,
      elements: draggables,
      atTheTop: true,
      getWidget: (DragPieceState drag, Offset offset){
        return DragPiece(piece: drag.piece,
          shapeConfig: shapeConfig,
          initPosition: offset,
          bloc: widget.bloc,
          disabled: drag.disabled,
        );
      },
    );
    return List.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces<E>({
    @required final BuildContext context,
    @required final List<E> elements,
    @required final bool atTheTop,
    @required Function getWidget
  }) {
    final positions = PositionHelper.generateEquidistantXPositions(context, elements.length);
    return elements.map((element) {
      final xPosition = positions.removeAt(0);
      final yPosition = PositionHelper.generateEquidistantYPosition(context, atTheTop);
      final offset = Offset(xPosition, yPosition);
      return BlocProvider(
        bloc: widget.bloc,
        child: getWidget(element, offset)
      );
    }).toList();
  }

}