import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/repository/utils/random_factory.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';
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
          children: _buildDraggableAndTargets(state.words),
        ),
      ),
    );
  }

  List<Widget> _buildDraggableAndTargets(List<Word> words) {
    List<Widget> targetBoxes = _buildBoxes(words: words, isTarget: true);
    List<Widget> dragBoxes = _buildBoxes(words: words);
    return List.from(dragBoxes)..addAll(targetBoxes);
  }

  List<Widget> _buildBoxes({List<Word> words, bool isTarget = false}) {
    final List<double> positions = generateXPositions(words.length);
    final List<Widget> boxes = [];
    words.forEach((word) {
      final xPosition = positions.removeLast();
      boxes.add(isTarget
          ? TargetBox(initPosition: Offset(xPosition, 220.0), word: word)
          : BlocProvider(
              bloc: widget.bloc,
              child:
                  DragBox(initPosition: Offset(xPosition, 20.0), word: word)));
    });
    return boxes;
  }

  List<double> generateXPositions(int numberOfBoxes) {
    final width = MediaQuery.of(context).size.width;
    final distance = width / numberOfBoxes;

    final List<double> results = [];
    for (int i = 0; i < numberOfBoxes; i++) {
      results.add((distance * (i + 1 / 2)) - Box.BOX_SIZE / 2);
    }
    results.shuffle();
    return results;
  }
}
