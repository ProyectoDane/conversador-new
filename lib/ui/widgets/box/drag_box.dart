import 'package:flutter/material.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  static const String SUCCESSFUL_SOUND = 'sounds/successful.mp3';
  static const String FAILURE_SOUND = 'sounds/failure.mp3';

  CardsBloc _bloc;
  Offset _origin;
  Offset _position;
  Color _color;

  AnimationController _controller;
  Animation<Offset> offsetTween;

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  void didUpdateWidget(DragBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    setUp();
  }

  void setUp() {
    _bloc = BlocProvider.of(context);
    setUpPositions();
    _color = widget.word.color;
    setUpAnimation();
  }

  void setUpPositions() {
    _origin = widget.initPosition;
    _position = widget.initPosition;
  }

  void setUpAnimation() {
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    offsetTween = Tween<Offset>(begin: _position, end: _origin).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Positioned(
            left: offsetTween.value.dx,
            top: offsetTween.value.dy,
            child: buildDraggable(),
          );
        });
  }

  Widget buildDraggable() {
    return Draggable(
      data: widget.word,
      child: widget.buildBox(
          size: Box.DRAGGABLE_BOX_SIZE,
          fontSize: Box.FONT_SIZE,
          boxColor: _color),
      onDraggableCanceled: (_, offset) => goBackLastPosition(offset),
      onDragCompleted: success,
      feedback: widget.buildBox(
          size: Box.DRAGGABLE_BOX_SIZE_FEEDBACK,
          fontSize: Box.FONT_SIZE_FEEDBACK,
          boxColor: _color.withOpacity(0.5)),
    );
  }

  void goBackLastPosition(Offset position) {
    setState(() => _position = position);
    setUpAnimation();
    _controller.forward();
    playFailure();
  }

  void success() async {
    setState(() => _color = _color.withOpacity(0.2));
    playSuccessful();
    await Future.delayed(
        const Duration(milliseconds: Box.ANIMATION_DURATION_MS), () => _bloc.boxSuccess());
  }

  void playSuccessful() => widget.audioCache.play(SUCCESSFUL_SOUND);

  void playFailure() => widget.audioCache.play(FAILURE_SOUND);
}
