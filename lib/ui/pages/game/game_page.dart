import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/util/positions_helper.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/drag_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/target_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';

class GamePage extends StatelessWidget {
  final _bloc;

  GamePage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _GameBody(_bloc),
    );
  }
}

class _GameBody extends StatefulWidget {
  final GameBloc bloc;

  _GameBody(this.bloc);

  @override
  State createState() => _GameBodyState();
}

class _GameBodyState extends State<_GameBody> {
  Widget _toRender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEvent, GameState>(
      bloc: widget.bloc,
      builder: (BuildContext context, GameState state) => _render(state),
    );
  }

  Widget _render(final GameState state) {
    if (state is InitialState) {
      _toRender = _renderInitial();
    }

    if (state is ErrorState) {
      _toRender = _renderError(state);
    }

    if (state is NextStageState) {
      _toRender = _renderStage(state.pieces, state.shapeConfig, state.backgroundUri);
    }

    if (state is NextLevelState) {
      _toRender = _renderStage(state.pieces, state.shapeConfig, state.backgroundUri);
    }

    return _toRender;
  }

  Widget _renderInitial() {
    widget.bloc.startStage();
    return Center(child: CircularProgressIndicator());
  }

  Widget _renderError(final ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }

  Widget _renderStage(final List<Piece> pieces, final ShapeConfig shapeConfig, final String backgroundUri) {
    return Container(
      decoration: WidgetUtils.getBackground(backgroundUri),
      child: SafeArea(
        child: Stack(children: _buildDraggableAndTargets(pieces, shapeConfig)),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(final List<Piece> pieces, final ShapeConfig shapeConfig) {
    final targetPieces = _buildPieces(pieces: pieces, shapeConfig: shapeConfig);
    final dragPieces = _buildPieces(pieces: pieces, shapeConfig: shapeConfig, isDrag: true);
    return List.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces({
    @required final List<Piece> pieces,
    @required final ShapeConfig shapeConfig,
    final bool isDrag = false,
  }) {
    final positions = PositionHelper.generateEquidistantXPositions(context, isDrag, pieces.length);
    return pieces.map((piece) {
      final xPosition = positions.removeAt(0);
      return _buildPiece(
        piece: piece,
        shapeConfig: shapeConfig,
        isDrag: isDrag,
        xPosition: xPosition,
      );
    }).toList();
  }

  Widget _buildPiece({
    @required final Piece piece,
    @required final shapeConfig,
    @required final bool isDrag,
    @required final double xPosition,
  }) {
    final yPosition = PositionHelper.generateEquidistantYPosition(context, isDrag);
    return BlocProvider(
      bloc: widget.bloc,
      child: isDrag
          ? DragPiece(piece: piece, shapeConfig: shapeConfig, initPosition: Offset(xPosition, yPosition))
          : TargetPiece(piece: piece, shapeConfig: shapeConfig, initPosition: Offset(xPosition, yPosition)),
    );
  }
}
