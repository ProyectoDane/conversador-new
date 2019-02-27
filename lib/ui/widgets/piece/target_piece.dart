import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_state.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/opacity_animation.dart';

class TargetPiece extends StatefulWidget {
  static const int _ANIMATION_TIME_MS = 1500;
  static const int _ANIMATION_TIME_FAST_MS = _ANIMATION_TIME_MS ~/ 2;
  static const Duration NORMAL = const Duration(milliseconds: _ANIMATION_TIME_MS);
  static const Duration FAST = const Duration(milliseconds: _ANIMATION_TIME_FAST_MS);

  final Piece piece;
  final ShapeConfig shapeConfig;
  final Offset initPosition;

  TargetPiece({@required this.piece, @required this.shapeConfig, @required this.initPosition});

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
    _sizeAnimation = Tween(begin: 0.0, end: Piece.BASE_SIZE).animate(_sizeController);
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
  Widget build(BuildContext context) => BlocBuilder<GameEvent, GameState>(
        bloc: _bloc,
        builder: (BuildContext context, GameState state) => _render(state),
      );

  Widget _render(final GameState state) {
    if (state is FailContentState) {
      _renderFail(state);
    }

    if (state is WaitingForAnimationState) {
      _renderWaitingForAnimation(state);
    }

    return _toRender;
  }

  void _renderFail(final FailContentState state) {
    final shouldNotAnimate = widget.piece.concept != state.concept || state.attempts <= 1;
    if (shouldNotAnimate) {
      return;
    }

    if (state.attempts == 2) {
      _opacityController.forward().whenComplete(_opacityController.reverse);
      return;
    }

    // state.attempts == 3
    _sizeController.forward().whenComplete(_bloc.animationCompleted);
  }

  void _renderWaitingForAnimation(final WaitingForAnimationState state) {
    final hasToAnimate = widget.piece.concept == state.concept;
    if (hasToAnimate) {
      _sizeController.forward().whenComplete(_bloc.animationCompleted);
    }
  }

  Widget _renderInitial() => Positioned(
        left: widget.initPosition.dx,
        top: widget.initPosition.dy,
        child: DragTarget(
            onWillAccept: (String content) => content == widget.piece.concept.value,
            onAccept: (_) {
              _sizeController.forward().whenComplete(_bloc.animationCompleted);
            },
            builder: (context, accepted, rejected) {
              return OpacityAnimation.animate(
                opacityAnimation: _opacityAnimation,
                sizeAnimation: _sizeAnimation,
                piece: widget.piece,
                shapeConfig: widget.shapeConfig,
              );
            }),
      );
}
