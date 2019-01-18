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
  void initState() {
    super.initState();
    widget.bloc.startStage();
    _toRender = _renderInitial();
  }

  Widget _renderInitial() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEvent, GameState>(
      bloc: widget.bloc,
      builder: (BuildContext context, GameState state) => _render(state),
    );
  }

  Widget _render(GameState state) {
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

  Widget _renderError(ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }

  Widget _renderStage(List<Piece> pieces, ShapeConfig shapeConfig, String backgroundUri) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundUri),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Stack(children: _buildDraggableAndTargets(pieces, shapeConfig)),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(List<Piece> pieces, ShapeConfig shapeConfig) {
    final targetPieces = _buildPieces(pieces: pieces, shapeConfig: shapeConfig);
    final dragPieces = _buildPieces(pieces: pieces, shapeConfig: shapeConfig, isDrag: true);
    return List.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces({@required List<Piece> pieces, @required ShapeConfig shapeConfig, bool isDrag = false}) {
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
    @required Piece piece,
    @required shapeConfig,
    @required bool isDrag,
    @required double xPosition,
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
