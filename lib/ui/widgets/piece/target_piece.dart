import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/opacity_animation.dart';

class TargetPiece extends StatefulWidget {
  static const int _ANIMATION_TIME_MS = 1500;
  static const int _ANIMATION_TIME_FAST_MS = _ANIMATION_TIME_MS ~/ 2;
  static const Duration NORMAL = const Duration(milliseconds: _ANIMATION_TIME_MS);
  static const Duration FAST = const Duration(milliseconds: _ANIMATION_TIME_FAST_MS);

  final Piece piece;
  final ShapeConfig shapeConfig;
  final Offset initPosition;
  final TargetPieceVisualState visualState;
  final LiveStageBloc bloc;

  TargetPiece({@required this.piece,
    @required this.shapeConfig,
    @required this.initPosition,
    @required this.visualState,
    @required this.bloc});

  @override
  State<StatefulWidget> createState() => _TargetPieceState();
}

class _TargetPieceState extends State<TargetPiece> with TickerProviderStateMixin {

  AnimationController _sizeController;
  AnimationController _opacityController;
  Animation<double> _sizeAnimation;
  Animation<double> _opacityAnimation;
  Widget _toRender;

  LiveStageBloc _bloc;
  Piece _piece;
  ShapeConfig _shapeConfig;
  Offset _initPosition;
  TargetPieceVisualState _visualState;
  TargetPieceVisualState _oldVisualState;

  _TargetPieceState();

  @override
  void initState() {
    super.initState();
    _setUpData();
    _setUpRender();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUpData();
    _setUpRender();
  }

  void _setUpData() {
    _visualState = widget.visualState;
    _initPosition = widget.initPosition;
    _shapeConfig = widget.shapeConfig;
    _piece = widget.piece;
    _bloc = widget.bloc;
  }

  void _setUpRender() {
    switch (_visualState) {
      case TargetPieceVisualState.normal:
        _setUpAnimation();
        _toRender = _renderInitial();
        break;
      case TargetPieceVisualState.warning:
      case TargetPieceVisualState.completed:
        break;
      case TargetPieceVisualState.animated:
        _toRender = _renderAnimated();
        break;
    }
  }

  void _setUpAnimation() {
    _sizeController = AnimationController(duration: TargetPiece.NORMAL, vsync: this);
    _sizeAnimation = Tween(begin: 0.0, end: Piece.BASE_SIZE).animate(_sizeController);
    _opacityController = AnimationController(duration: TargetPiece.FAST, vsync: this);
    _opacityAnimation = CurvedAnimation(parent: _opacityController, curve: Curves.decelerate);
  }

  void dispose() {
    _sizeController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _render();

  Widget _render() {
    if (_oldVisualState != _visualState) {
      _oldVisualState = _visualState;
      switch (_visualState) {
        case TargetPieceVisualState.normal:
        case TargetPieceVisualState.animated:
          break;
        case TargetPieceVisualState.warning:
          _opacityController.forward().whenComplete(_opacityController.reverse).whenComplete((){ _bloc.completedWarningAnimation(_piece); });
          break;
        case TargetPieceVisualState.completed:
          _sizeController.forward().whenComplete((){ _bloc.completedSuccessAnimation(_piece); });
          break;
      }
    }
    return _toRender;
  }

  Widget _renderInitial() => Positioned(
        left: _initPosition.dx,
        top: _initPosition.dy,
        child: DragTarget(
            onWillAccept: (Piece piece){
              return piece.concept == _piece.concept;
            },
            onAccept: (Piece piece){
              _bloc.pieceSuccess(dragPiece: piece, targetPiece: _piece);
            },
            builder: (context, accepted, rejected) {
              return OpacityAnimation.animate(
                opacityAnimation: _opacityAnimation,
                sizeAnimation: _sizeAnimation,
                piece: _piece,
                shapeConfig: _shapeConfig,
              );
            }),
      );

  Widget _renderAnimated() => Positioned(
    left: _initPosition.dx,
    top: _initPosition.dy,
    child: OpacityAnimation.animate(
      opacityAnimation: _opacityAnimation,
      sizeAnimation: _sizeAnimation,
      piece: _piece,
      shapeConfig: _shapeConfig,
    ),
  );
}
