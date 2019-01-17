import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
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
      _toRender = _renderStage(state.pieces, state.backgroundUri);
    }

    if (state is NextLevelState) {
      _toRender = _renderStage(state.pieces, state.backgroundUri);
    }

    return _toRender;
  }

  Widget _renderError(ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }

  Widget _renderStage(List<Piece> pieces, String backgroundUri) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundUri),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Stack(children: _buildDraggableAndTargets(pieces)),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(List<Piece> pieces) {
    final targetPieces = _buildPieces(pieces: pieces);
    final dragPieces = _buildPieces(pieces: pieces, isDrag: true);
    return List.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces({@required List<Piece> pieces, bool isDrag = false}) {
    final positions = PositionHelper.generateEquidistantXPositions(context, isDrag, pieces.length);
    return pieces.map((piece) {
      final xPosition = positions.removeAt(0);
      return _buildPiece(isDrag, xPosition, piece);
    }).toList();
  }

  Widget _buildPiece(bool isDrag, double xPosition, Piece piece) {
    final yPosition = PositionHelper.generateEquidistantYPosition(context, isDrag);
    return BlocProvider(
      bloc: widget.bloc,
      child: isDrag
          ? DragPiece(initPosition: Offset(xPosition, yPosition), piece: piece)
          : TargetPiece(initPosition: Offset(xPosition, yPosition), piece: piece),
    );
  }
}
