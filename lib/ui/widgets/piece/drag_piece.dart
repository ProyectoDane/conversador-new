import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game/game_bloc.dart';
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

  DragPiece({@required this.piece, @required this.shapeConfig, @required this.initPosition});

  @override
  State<StatefulWidget> createState() => _DragPieceState();
}

class _DragPieceState extends State<DragPiece> with TickerProviderStateMixin {
  GameBloc _bloc;
  int _attempts;
  Offset _origin;
  Offset _position;
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
    _isDisabled = false;
    _setUpAnimation();
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
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget _buildDraggable() {
    return Draggable(
      data: widget.piece.concept.value,
      child: widget.piece.buildWidget(
        pieceType: Piece.DRAG_INITIAL,
        shapeConfig: widget.shapeConfig,
      ),
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
            _bloc.pieceSuccess(widget.piece.concept);
            _isDisabled = true;
          },
        ));
      },
      feedback: widget.piece.buildWidget(
        pieceType: Piece.DRAG_FEEDBACK,
        shapeConfig: widget.shapeConfig,
      ),
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
    if (_attempts < 3) {
      _bloc.failedAttempt(widget.piece.concept, _attempts);
      return;
    }

    // attempts == 3
    setState(() => _isDisabled = true);
    _bloc.pieceSuccess(widget.piece.concept);
  }
}
