import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/util/operators.dart';

/// Piece to be dragged around to match a target.
/// It contains a string and is configured by PieceConfig.
class DragPiece extends StatefulWidget {

  /// Creates a DragPiece from
  /// - the piece to represent
  /// - the piece configuration to follow
  /// - the position where it should start (top left corner)
  /// - whether it's disabled or not
  /// - the Bloc to which to notify events.
  DragPiece({
    @required this.piece,
    @required this.pieceConfig,
    @required this.initPosition,
    @required this.bloc,
    @required this.disabled
  });
  
  static const int _ANIMATION_TIME_MS = 1500;
  static const Duration _DURATION = Duration(milliseconds: _ANIMATION_TIME_MS);
  final AudioCache _audioCache = AudioCache();

  /// Piece which this represents
  final Piece piece;
  /// Configuration to mold the piece by
  final PieceConfig pieceConfig;
  /// Origin of the piece (top left corner)
  final Offset initPosition;
  /// Bloc to which to notify events
  final LiveStageBloc bloc;
  /// Whether the piece is disabled or not
  final bool disabled;


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
    _controller = AnimationController(
        duration: DragPiece._DURATION,
        vsync: this
    );
    _movementAnimation = Tween<Offset>(begin: _position, end: _origin)
        .animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut
        ));
  }

  @override
  void didUpdateWidget(DragPiece oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUp();
    if (oldWidget.initPosition != widget.initPosition) {
      _setUpAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _render();

  Widget _render() =>
    AnimatedBuilder(
      animation: _movementAnimation,
      builder: (BuildContext context, Widget child) =>
        Positioned(
          left: _movementAnimation.value.dx,
          top: _movementAnimation.value.dy,
          child: _isDisabled
              ? widget.piece.buildWidget(
            pieceType: Piece.DRAG_COMPLETED,
            pieceConfig: widget.pieceConfig,
          )
              : _buildDraggable(),
        )
    );

  Widget _buildDraggable() => Draggable<Piece>(
      data: widget.piece,
      child: widget.piece.buildWidget(
        pieceType: Piece.DRAG_INITIAL,
        pieceConfig: widget.pieceConfig,
      ),
      onDraggableCanceled: (_, Offset offset) {
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
        pieceConfig: widget.pieceConfig,
      ),
    );

  void _renderOperator(final Operator operator) {
    setState(operator.newState);
    widget._audioCache.play(operator.sound, volume: operator.volume);
    _playAnimation();
  }

  void _playAnimation() {
    _setUpAnimation();
    _controller.forward();
  }
}