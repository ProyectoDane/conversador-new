import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/ui/pages/cards/positions_helper.dart';
import 'package:flutter_cards/ui/widgets/box/drag_box.dart';
import 'package:flutter_cards/ui/widgets/box/target_box.dart';
import 'package:flutter_cards/ui/widgets/platform/platform_scaffold.dart';

class CardsPage extends StatelessWidget {
  final _bloc;

  CardsPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(title: 'Words', child: _CardsBody(_bloc));
  }
}

class _CardsBody extends StatefulWidget {
  final CardsBloc bloc;

  _CardsBody(this.bloc);

  @override
  State createState() => _CardsBodyState();
}

class _CardsBodyState extends State<_CardsBody> {
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
          onPressed: widget.bloc.loadWords,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsEvent, CardsState>(
      bloc: widget.bloc,
      builder: (BuildContext context, CardsState state) => _render(state),
    );
  }

  Widget _render(CardsState state) {
    // TODO is it necessary another bloc?
    if (state.isError()) {
      _toRender = _renderError(state);
    }

    if (state.isNextLevel()) {
      _toRender = _renderNextLevel(state);
    }

    if (state.isWaitingForNextLevel()) {
      _toRender = _renderWaitingForNextLevel();
    }

    return _toRender;
  }

  Widget _renderError(CardsState state) {
    return Center(child: Text(state.errorMessage));
  }

  Widget _renderNextLevel(CardsState state) {
    return SafeArea(
      child: Stack(
        children: _buildDraggableAndTargets(state.words),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(List<Word> words) {
    final targetBoxes = _buildBoxes(words: words, isTarget: true);
    final dragBoxes = _buildBoxes(words: words);
    return List.from(dragBoxes)..addAll(targetBoxes);
  }

  List<Widget> _buildBoxes({@required List<Word> words, bool isTarget = false}) {
    final positions = PositionHelper.generateEquidistantPositions(context, words.length);
    return words.map((word) {
      final xPosition = positions.removeLast();
      return _buildBox(isTarget, xPosition, word);
    }).toList();
  }

  Widget _buildBox(bool isTarget, double xPosition, Word word) {
    return BlocProvider(
      bloc: widget.bloc,
      child: isTarget
          ? TargetBox(initPosition: Offset(xPosition, 220.0), word: word)
          : DragBox(initPosition: Offset(xPosition, 20.0), word: word),
    );
  }

  Widget _renderWaitingForNextLevel() {
    // TODO there is a bug here. Cancel it
    Timer(const Duration(seconds: 2), () => widget.bloc.levelCompleted());
    return Center(child: CircularProgressIndicator());
  }
}
