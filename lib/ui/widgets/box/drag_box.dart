import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';

class DragBox extends Box {
  final audioCache = AudioCache();

  DragBox({
    @required initPosition,
    @required word,
  }) : super(initPosition: initPosition, word: word);

  @override
  State<StatefulWidget> createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> with TickerProviderStateMixin {
  int _attempts = 0;
  CardsBloc _bloc;
  Offset _origin;
  Offset _position;
  Color _color;

  AnimationController _controller;
  Animation<Offset> offsetTween;

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  void didUpdateWidget(DragBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUp();
  }

  void _setUp() {
    _bloc = BlocProvider.of(context);
    _setUpPositions();
    _color = widget.word.color;
    _setUpAnimation();
  }

  void _setUpPositions() {
    _origin = widget.initPosition;
    _position = widget.initPosition;
  }

  void _setUpAnimation() {
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    offsetTween = Tween<Offset>(begin: _position, end: _origin)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Positioned(
            left: offsetTween.value.dx,
            top: offsetTween.value.dy,
            child: _buildDraggable(),
          );
        });
  }

  Widget _buildDraggable() {
    return Draggable(
      data: widget.word,
      child: widget.buildBox(size: Box.DRAGGABLE_BOX_SIZE, fontSize: Box.FONT_SIZE, boxColor: _color),
      onDraggableCanceled: (_, offset) {
        _render(Operator.failure(() {
          _position = offset;
        }));
      },
      onDragCompleted: () {
        _render(Operator.success(() {
          _color = _color.withOpacity(0.2);
          // TODO use events not a timer
          Future.delayed(const Duration(milliseconds: Box.ANIMATION_DURATION_MS), () => _bloc.boxSuccess());
        }));
      },
      feedback: widget.buildBox(
          size: Box.DRAGGABLE_BOX_SIZE_FEEDBACK, fontSize: Box.FONT_SIZE_FEEDBACK, boxColor: _color.withOpacity(0.5)),
    );
  }

  void _render(Operator operator) {
    setState(operator.action);
    widget.audioCache.play(operator.sound);
    _setUpAnimation();
    _controller.forward();
    _notifyFailure(operator.shouldNotifyFailure);
  }

  void _notifyFailure(bool shouldNotify) {
    if (shouldNotify) {
      _attempts = _attempts + 1;
      _bloc.failedAttempt(widget.word, _attempts);
      if (_attempts == 2) {
        setState(() => _color = _color.withOpacity(0.2));
        // TODO use events not a timer
        Future.delayed(const Duration(milliseconds: Box.ANIMATION_DURATION_MS), () => _bloc.boxSuccess());
      }
    }
  }
}

// TODO remove operator
class Operator {
  static const String SUCCESSFUL_SOUND = 'sounds/successful.mp3';
  static const String FAILURE_SOUND = 'sounds/failure.mp3';

  String sound;
  Function action;
  bool shouldNotifyFailure;

  Operator({this.sound, this.action, this.shouldNotifyFailure = false});

  factory Operator.success(action) => Operator(sound: SUCCESSFUL_SOUND, action: action);

  factory Operator.failure(action) => Operator(sound: FAILURE_SOUND, action: action, shouldNotifyFailure: true);
}
