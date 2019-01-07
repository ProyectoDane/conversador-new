import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/word.dart';
import 'package:flutter_syntactic_sorter/ui/pages/game/util/positions_helper.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/drag_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/target_piece.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';

class GamePage extends StatelessWidget {
  final _bloc;

  GamePage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(title: 'Words', child: _GameBody(_bloc));
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
    _toRender = _renderInitial();
  }

  Widget _renderInitial() {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text("START GAME"),
          onPressed: widget.bloc.startLevel,
        ),
      ),
    );
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
    return SafeArea(
      child: Stack(
        children: _buildDraggableAndTargets(state.words),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(List<Word> words) {
    final targetPieces = _buildPieces(words: words, isTarget: true);
    final dragPieces = _buildPieces(words: words);
    return List.from(dragPieces)..addAll(targetPieces);
  }

  List<Widget> _buildPieces({@required List<Word> words, bool isTarget = false}) {
    final positions = PositionHelper.generateEquidistantPositions(context, words.length);
    return words.map((word) {
      final xPosition = positions.removeLast();
      return _buildPiece(isTarget, xPosition, word);
    }).toList();
  }

  Widget _buildPiece(bool isTarget, double xPosition, Word word) {
    return BlocProvider(
      bloc: widget.bloc,
      child: isTarget
          ? TargetPiece(initPosition: Offset(xPosition, 220.0), word: word)
          : DragPiece(initPosition: Offset(xPosition, 20.0), word: word),
    );
  }
}
