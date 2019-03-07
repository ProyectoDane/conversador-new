import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/util/operators.dart';

class DragPiece extends StatefulWidget {
  static const int ANIMATION_TIME_MS = 1500;
  static const Duration DURATION = const Duration(milliseconds: ANIMATION_TIME_MS);
  final audioCache = AudioCache();

  final Piece piece;
  final ShapeConfig shapeConfig;
  final Offset initPosition;
  final LiveStageBloc bloc;
  final bool disabled;

  DragPiece({@required this.piece, @required this.shapeConfig, @required this.initPosition, @required this.bloc, @required this.disabled});

  @override
  State<StatefulWidget> createState() => _DragPieceState();
}

class _DragPieceState extends State<DragPiece> with TickerProviderStateMixin {
  LiveStageBloc _bloc;
  Offset _origin;
  Offset _position;
  bool _isDisabled;
  AnimationController _controller;
  Animation<Offset> _movementAnimation;

  @override
  void initState() {
    super.initState();
    _setUp();
    _setUpAnimation();
  }

  void _setUp() {
    _origin = widget.initPosition;
    _position = widget.initPosition;
    _isDisabled = widget.disabled;
    _bloc = widget.bloc;
  }

  void _setUpAnimation() {
    _controller = AnimationController(duration: DragPiece.DURATION, vsync: this);
    _movementAnimation = Tween<Offset>(begin: _position, end: _origin)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUp();
    if ((oldWidget as DragPiece).initPosition != widget.initPosition) {
      _setUpAnimation();
    }
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _render();

  Widget _render() {
    return AnimatedBuilder(
      animation: _movementAnimation,
      builder: (BuildContext context, Widget child) {
        return Positioned(
          left: _movementAnimation.value.dx,
          top: _movementAnimation.value.dy,
          child: _isDisabled
              ? widget.piece.buildWidget(
            pieceType: Piece.DRAG_COMPLETED,
            shapeConfig: widget.shapeConfig,
          )
              : _buildDraggable(),
        );
      },
    );
  }

  Widget _buildDraggable() => Draggable(
      data: widget.piece,
      child: widget.piece.buildWidget(
        pieceType: Piece.DRAG_INITIAL,
        shapeConfig: widget.shapeConfig,
      ),
      onDraggableCanceled: (_, offset) {
        _renderOperator(Operator.failure(
          newState: () {
            _position = offset;
            _bloc.pieceFailure(widget.piece);
          },
        ));
      },
      onDragCompleted: () {
        _renderOperator(Operator.success(newState: (){ }));
      },
      feedback: widget.piece.buildWidget(
        pieceType: Piece.DRAG_FEEDBACK,
        shapeConfig: widget.shapeConfig,
      ),
    );

  void _renderOperator(final Operator operator) {
    setState(operator.newState);
    widget.audioCache.play(operator.sound);
    _playAnimation();
  }

  void _playAnimation() {
    _setUpAnimation();
    _controller.forward();
  }
}