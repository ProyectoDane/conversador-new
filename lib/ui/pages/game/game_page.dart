import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/piece.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/util/positions_helper.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/drag_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/target_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';

class GamePage extends StatelessWidget {
  final _bloc;

  GamePage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(title: 'Game', body: _GameBody(_bloc));
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
    widget.bloc.startLevel();
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

    if (state is NextLevelState) {
      _toRender = _renderNextLevel(state);
    }

    return _toRender;
  }

  Widget _renderError(ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }

  Widget _renderNextLevel(NextLevelState state) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/game/background.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Stack(children: _buildDraggableAndTargets(state.pieces)),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(List<Piece> pieces) {
    final targetPieces = _buildPieces(pieces: pieces, isTarget: true);
    final dragPieces = _buildPieces(pieces: pieces);
    return List.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces({@required List<Piece> pieces, bool isTarget = false}) {
    final positions = PositionHelper.generateEquidistantPositions(context, pieces.length);
    return pieces.map((piece) {
      final xPosition = positions.removeLast();
      return _buildPiece(isTarget, xPosition, piece);
    }).toList();
  }

  Widget _buildPiece(bool isTarget, double xPosition, Piece piece) {
    return BlocProvider(
      bloc: widget.bloc,
      child: isTarget
          ? TargetPiece(initPosition: Offset(xPosition, 220.0), piece: piece)
          : DragPiece(initPosition: Offset(xPosition, 20.0), piece: piece),
    );
  }
}
