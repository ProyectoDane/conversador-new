import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/ui/widgets/animation/target_animation.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';

class TargetBox extends Box {
  TargetBox({
    @required initPosition,
    @required word,
  }) : super(initPosition: initPosition, word: word);

  @override
  State<StatefulWidget> createState() => _TargetBoxState();
}

class _TargetBoxState extends State<TargetBox> with SingleTickerProviderStateMixin {
  bool _thisTargetFailed(Word word) => widget.word == word;

  bool _isCompleted = false;

  Color _selectedColor;
  CardsBloc _bloc;

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setUp();
  }

  void setUp() {
    _bloc = BlocProvider.of(context);
    _selectedColor = Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsEvent, CardsState>(
      bloc: _bloc,
      builder: (BuildContext context, CardsState state) {
        if (_thisTargetFailed(state.word)) {
          _renderFail(state.word, state.attempts);
        }

        return Positioned(
          left: widget.initPosition.dx,
          top: widget.initPosition.dy,
          child: _buildDrag(),
        );
      },
    );
  }

  void _renderFail(Word word, int attempts) {
    if (attempts == 1) {
      // TODO render animation 1
    }

    if (attempts == 2) {
      _isCompleted = true;
      _selectedColor = word.color;
    }
  }

  Widget _buildDrag() {
    return DragTarget(
      onWillAccept: (word) => word.id == widget.word.id,
      onAccept: (Word word) => _autoComplete(word),
      builder: (context, accepted, rejected) => _checkAccepted(),
    );
  }

  void _autoComplete(Word word) {
    setState(() {
      _isCompleted = true;
      _selectedColor = word.color;
    });
  }

  Widget _checkAccepted() {
    return (_isCompleted)
        ? TargetAnimation(label: widget.word.value, color: _selectedColor)
        : widget.buildBox(
            size: Box.TARGET_BOX_SIZE_COMPLETE, fontSize: Box.FONT_SIZE_FEEDBACK, boxColor: _selectedColor);
  }
}
