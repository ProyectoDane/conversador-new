import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/repository/utils/random_factory.dart';
import 'package:flutter_cards/ui/widgets/box/drag_box.dart';
import 'package:flutter_cards/ui/widgets/box/target_box.dart';
import 'package:flutter_cards/ui/widgets/platform/platform_scaffold.dart';

class CardsPage extends StatelessWidget {
  final CardsBloc _bloc;

  CardsPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(title: 'Words', child: CardsBody(bloc: _bloc));
  }
}

class CardsBody extends StatefulWidget {
  final CardsBloc bloc;

  CardsBody({@required this.bloc});

  @override
  _CardsBodyState createState() => _CardsBodyState();
}

class _CardsBodyState extends State<CardsBody> {
  bool _error(CardsState state) => state.errorMessage.isNotEmpty;
  bool _nextLevel(CardsState state) => state.words.isNotEmpty;
  bool _waitingForNextLevel(CardsState state) => state.waiting;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsEvent, CardsState>(
      bloc: widget.bloc,
      builder: (BuildContext context, CardsState state) {
        Widget toRender = _renderInitial();
        if (_error(state)) {
          toRender = _renderError(state);
        }

        if (_nextLevel(state)) {
          toRender = _renderNextLevel(state);
        }

        if (_waitingForNextLevel(state)) {
          toRender = _renderWaitingForNextLevel();
        }
        return toRender;
      },
    );
  }

  Widget _renderInitial() => Center(
        child: Container(
          child: RaisedButton(
            child: Text("START GAME"),
            onPressed: widget.bloc.loadWords,
          ),
        ),
      );

  Widget _renderError(CardsState state) =>
      Center(child: Text(state.errorMessage));

  Widget _renderWaitingForNextLevel() {
    Future.delayed(
        const Duration(seconds: 2), () => widget.bloc.levelCompleted());
    return Center(child: CircularProgressIndicator());
  }

  Widget _renderNextLevel(CardsState state) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: _buildBoxesAndTargets(state.words),
        ),
      ),
    );
  }

  List<Widget> _buildBoxesAndTargets(List<Word> words) {
    final List<double> dragPositions =
        RandomFactory.generateXPositions(context, words.length);
    final List<double> targetPositions =
        RandomFactory.generateXPositions(context, words.length);
    final List<Widget> dragBoxes = [];
    final List<Widget> targetBoxes = [];
    words.forEach((word) {
      final xDragPosition = dragPositions.removeLast();
      final xTargetPosition = targetPositions.removeLast();

      dragBoxes.add(BlocProvider(
        bloc: widget.bloc,
        child: DragBox(
          initPosition: Offset(xDragPosition, 20.0),
          word: word,
        ),
      ));
      targetBoxes.add(
          TargetBox(initPosition: Offset(xTargetPosition, 220.0), word: word));
    });

    return List.from(dragBoxes)..addAll(targetBoxes);
  }
}
