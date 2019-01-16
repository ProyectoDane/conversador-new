import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape.dart';

class TargetPiece extends StatefulWidget {
  static const int _ANIMATION_TIME_MS = 1500;
  static const int _ANIMATION_TIME_FAST_MS = _ANIMATION_TIME_MS ~/ 2;
  static const Duration NORMAL = const Duration(milliseconds: _ANIMATION_TIME_MS);
  static const Duration FAST = const Duration(milliseconds: _ANIMATION_TIME_FAST_MS);

  final Offset initPosition;
  final Piece piece;

  TargetPiece({@required this.initPosition, @required this.piece});

  @override
  State<StatefulWidget> createState() => _TargetPieceState();
}

class _TargetPieceState extends State<TargetPiece> with TickerProviderStateMixin {
  Widget _toRender;
  AnimationController _sizeController;
  AnimationController _opacityController;
  Animation<double> _sizeAnimation;
  Animation<double> _opacityAnimation;
  GameBloc _bloc;

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  void _setUp() {
    _bloc = BlocProvider.of(context);
    _setUpAnimation();
    _toRender = _renderInitial();
  }

  void _setUpAnimation() {
    _sizeController = AnimationController(duration: TargetPiece.NORMAL, vsync: this);
    _sizeAnimation = Tween(begin: 0.0, end: Shape.BASE_SIZE).animate(_sizeController);
    _opacityController = AnimationController(duration: TargetPiece.FAST, vsync: this);
    _opacityAnimation = CurvedAnimation(parent: _opacityController, curve: Curves.decelerate);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUp();
  }

  void dispose() {
    _sizeController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEvent, GameState>(
      bloc: _bloc,
      builder: (BuildContext context, GameState state) => _render(state),
    );
  }

  Widget _render(GameState state) {
    if (state is FailContentState) {
      _renderFail(state);
    }

    if (state is WaitingForAnimationState) {
      _renderWaitingForAnimation(state);
    }

    return _toRender;
  }

  void _renderFail(FailContentState state) {
    final shouldNotAnimate = widget.piece.content != state.content || state.attempts <= 1;
    if (shouldNotAnimate) {
      return;
    }

    if (state.attempts == 2) {
      _opacityController.forward().whenComplete(_opacityController.reverse);
    }

    if (state.attempts == 3) {
      _sizeController.forward().whenComplete(_bloc.animationCompleted);
    }
  }

  void _renderWaitingForAnimation(WaitingForAnimationState state) {
    final hasToAnimate = widget.piece.content == state.content;
    if (hasToAnimate) {
      _sizeController.forward().whenComplete(_bloc.animationCompleted);
    }
  }

  Widget _renderInitial() {
    return Positioned(
      left: widget.initPosition.dx,
      top: widget.initPosition.dy,
      child: DragTarget(
        onWillAccept: (String content) => content == widget.piece.content,
        onAccept: (_) {
          _sizeController.forward().whenComplete(_bloc.animationCompleted);
        },
        builder: (context, accepted, rejected) => _buildOpacityAnimation(),
      ),
    );
  }

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
              widget.piece.buildPiece(type: Piece.TARGET_COMPLETED, size: _sizeAnimation.value, showText: false),
              widget.piece.buildPiece(type: Piece.TARGET_INITIAL), // Text
            ],
          ),
        );
      },
    );
  }
}
