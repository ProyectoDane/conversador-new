import 'package:flutter/material.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';
import 'package:flutter_cards/ui/utils/constants.dart';
import 'package:audioplayers/audio_cache.dart';

class DragBox extends Box {
  DragBox({
    @required initPosition,
    @required word,
  }) : super(initPosition: initPosition, word: word);

  @override
  State<StatefulWidget> createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> with TickerProviderStateMixin {
  Offset _origin;
  Offset _position;
  Color _color;

  AnimationController _controller;
  Animation<Offset> offsetTween;

  final audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    setUpPositions();
    _color = widget.word.color;
    setUpAnimation();
  }

  void setUpPositions() {
    _origin = widget.initPosition;
    _position = widget.initPosition;
  }

  void setUpAnimation() {
    _controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
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
            child: buildDraggable(),
          );
        });
  }

  Widget buildDraggable() {
    return Draggable(
      data: widget.word,
      child: widget.buildBox(size: DRAGGABLE_BOX_SIZE, fontSize: FONT_SIZE, boxColor: _color),
      onDraggableCanceled: (velocity, offset) {
        goBackLastPosition(offset);
      },
      onDragCompleted: () {
        success();
      },
      feedback: widget.buildBox(size: DRAGGABLE_BOX_SIZE_FEEDBACK, fontSize: FONT_SIZE_FEEDBACK, boxColor: _color.withOpacity(0.5)),
    );
  }

  void goBackLastPosition(Offset position) {
    setState(() {
      _position = position;
    });
    setUpAnimation();
    _controller.forward();
    playFailure();
  }

  void success() {
    setState(() {
      _color = _color.withOpacity(0.2);
    });
    playSuccessful();
  }

  void playSuccessful() {
    audioCache.play('sounds/successful.mp3');
  }

  void playFailure() {
    audioCache.play('sounds/failure.mp3');
  }
}