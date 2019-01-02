import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';
import 'package:flutter_cards/ui/widgets/box/util/operators.dart';

class DragBox extends Box {
  static const int ANIMATION_TIME_MS = 1500;
  static const Duration DURATION = const Duration(milliseconds: ANIMATION_TIME_MS);
  final audioCache = AudioCache();

  DragBox({@required initPosition, @required word}) : super(initPosition: initPosition, word: word);

  @override
  State<StatefulWidget> createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> with TickerProviderStateMixin {
  CardsBloc _bloc;
  int _attempts;
  Offset _origin;
  Offset _position;
  Color _color;
  bool _isDisabled;
  AnimationController _controller;
  Animation<Offset> _movementAnimation;

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  void _setUp() {
    _bloc = BlocProvider.of(context);
    _attempts = 0;
    _origin = widget.initPosition;
    _position = widget.initPosition;
    _color = widget.word.color;
    _isDisabled = false;
    _setUpAnimation();
  }

  void _setUpAnimation() {
    _controller = AnimationController(duration: DragBox.DURATION, vsync: this);
    _movementAnimation = Tween<Offset>(begin: _position, end: _origin)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _movementAnimation,
      builder: (BuildContext context, Widget child) {
        return Positioned(
          left: _movementAnimation.value.dx,
          top: _movementAnimation.value.dy,
          child: _isDisabled ? widget.buildBox(boxColor: _color) : _buildDraggable(),
        );
      },
    );
  }

  Widget _buildDraggable() {
    return Draggable(
      data: widget.word,
      child: widget.buildBox(boxColor: _color),
      onDraggableCanceled: (_, offset) {
        _render(Operator.failure(
          newState: () {
            _position = offset;
          },
        ));
      },
      onDragCompleted: () {
        _render(Operator.success(
          newState: () {
            _color = _color.withOpacity(0.2);
            _bloc.boxSuccess(widget.word);
            _isDisabled = true;
          },
        ));
      },
      feedback: widget.buildBox(boxColor: _color.withOpacity(0.5)),
    );
  }

  void _render(Operator operator) {
    setState(operator.newState);
    widget.audioCache.play(operator.sound);
    _playAnimation();
    _notifyFailure(operator.shouldNotifyFailure);
  }

  void _playAnimation() {
    _setUpAnimation();
    _controller.forward();
  }

  void _notifyFailure(bool shouldNotify) {
    if (!shouldNotify) {
      return;
    }

    _attempts = _attempts + 1;
    if (_attempts == 1 || _attempts == 2) {
      _bloc.failedAttempt(widget.word, _attempts);
    }
    if (_attempts == 3) {
      setState(() {
        _color = _color.withOpacity(0.2);
        _isDisabled = true;
      });
      _bloc.boxSuccess(widget.word);
    }
  }
}
