import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/ui/widgets/piece/piece.dart';

class TargetBox extends Piece {
  static const int _ANIMATION_TIME_MS = 1500;
  static const int _ANIMATION_TIME_FAST_MS = _ANIMATION_TIME_MS ~/ 2;
  static const Duration NORMAL = const Duration(milliseconds: _ANIMATION_TIME_MS);
  static const Duration FAST = const Duration(milliseconds: _ANIMATION_TIME_FAST_MS);

  TargetBox({@required initPosition, @required word}) : super(initPosition: initPosition, word: word);

  @override
  State<StatefulWidget> createState() => _TargetBoxState();
}

class _TargetBoxState extends State<TargetBox> with TickerProviderStateMixin {
  Widget _toRender;
  AnimationController _sizeController;
  AnimationController _opacityController;
  Animation<double> _sizeAnimation;
  Animation<double> _opacityAnimation;
  Color _color;
  CardsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  void _setUp() {
    _bloc = BlocProvider.of(context);
    _color = Piece.COLOR;
    _setUpAnimation();
    _toRender = _renderInitial();
  }

  void _setUpAnimation() {
    _sizeController = AnimationController(duration: TargetBox.NORMAL, vsync: this);
    _sizeAnimation = Tween(begin: 0.0, end: Piece.SIZE).animate(_sizeController);
    _opacityController = AnimationController(duration: TargetBox.FAST, vsync: this);
    _opacityAnimation = CurvedAnimation(parent: _opacityController, curve: Curves.decelerate);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsEvent, CardsState>(
      bloc: _bloc,
      builder: (BuildContext context, CardsState state) => _render(state),
    );
  }

  Widget _render(CardsState state) {
    if (state is FailState) {
      _renderFail(state);
    }

    if (state is WaitingForAnimationState) {
      _renderWaitingForAnimation(state);
    }

    return _toRender;
  }

  void _renderFail(FailState state) {
    if (_shouldNotAnimate(state.word, state.attempts)) {
      return;
    }

    if (state.attempts == 2) {
      _color = Piece.COLOR;
      _opacityController.forward().whenComplete(_opacityController.reverse);
    }

    if (state.attempts == 3) {
      _color = state.word.shape.color;
      _sizeController.forward().whenComplete(_bloc.animationCompleted);
    }
  }

  bool _shouldNotAnimate(Word word, int attempts) => widget.word != word || attempts <= 1;

  void _renderWaitingForAnimation(WaitingForAnimationState state) {
    if (_hasToAnimate(state.word)) {
      _color = state.word.shape.color;
      _sizeController.forward().whenComplete(_bloc.animationCompleted);
    }
  }

  bool _hasToAnimate(Word word) => widget.word == word;

  Widget _renderInitial() {
    return Positioned(
      left: widget.initPosition.dx,
      top: widget.initPosition.dy,
      child: DragTarget(
        onWillAccept: (word) => word.id == widget.word.id,
        onAccept: (Word word) {
          _color = word.shape.color;
          _sizeController.forward().whenComplete(_bloc.animationCompleted);
        },
        builder: (context, accepted, rejected) => _buildAnimations(),
      ),
    );
  }

  Widget _buildAnimations() => _buildOpacityAnimation();

  Widget _buildOpacityAnimation() {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: 1 - _opacityAnimation.value,
          child: _buildRadiusAnimation(),
        );
      },
    );
  }

  Widget _buildRadiusAnimation() {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (BuildContext context, Widget child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              widget.buildPiece(size: _sizeAnimation.value, color: _color, showText: false),
              widget.buildPiece(), // Text
            ],
          ),
        );
      },
    );
  }
}
