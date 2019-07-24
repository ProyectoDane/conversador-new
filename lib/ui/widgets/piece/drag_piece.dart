import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/app/game/util/tts_manager.dart';
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
  const DragPiece({
    @required this.piece,
    @required this.pieceConfig,
    @required this.initPosition,
    @required this.disabled
  });
  
  static const int _ANIMATION_TIME_MS = 1500;
  static const Duration _DURATION = Duration(milliseconds: _ANIMATION_TIME_MS);

  /// Piece which this represents
  final Piece piece;
  /// Configuration to mold the piece by
  final PieceConfig pieceConfig;
  /// Origin of the piece (top left corner)
  final Offset initPosition;
  /// Whether the piece is disabled or not
  final bool disabled;


  @override
  State<StatefulWidget> createState() => _DragPieceState();
}

class _DragPieceState extends State<DragPiece> with TickerProviderStateMixin {
  Offset _origin;
  Offset _position;
  bool _isDisabled;
  AnimationController _controller;
  Animation<Offset> _movementAnimation;
  bool _shouldMovePieceBack = false;

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
      key: UniqueKey(),
      animation: _movementAnimation,
      builder: (BuildContext context, Widget child) =>
        Positioned(
          key: UniqueKey(),
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

  Widget _buildDraggable() { 
    // This gets called from the drag target listener to let it know it has
    // to return to it's place even though it passed over a target
    // It is executed before the onDragEnd is called.
    widget.piece.flagPieceReturn = () {
      _shouldMovePieceBack = true;
    };

    return Draggable<Piece>(
      key: UniqueKey(),
      data: widget.piece,
      child: GestureDetector(
        onTap: () {
          TtsManager().playConcept(widget.piece.concept);
        },
        child: widget.piece.buildWidget(
          pieceType: Piece.DRAG_INITIAL,
          pieceConfig: widget.pieceConfig,
        ),
      ),
      onDraggableCanceled: (_, Offset offset) {
        _renderOperator(Operator.failure(
          newState: () {
            _position = offset;
          },
        ));
      },
      onDragEnd: (DraggableDetails details) {
        if (_shouldMovePieceBack) {
          _shouldMovePieceBack = false;
          _renderOperator(Operator.failure(
          newState: () {
            _position = details.offset;
          }));
        }
      },
      feedback: widget.piece.buildWidget(
        pieceType: Piece.DRAG_FEEDBACK,
        pieceConfig: widget.pieceConfig,
      ),
    );
  }

  void _renderOperator(final Operator operator) {
    setState(operator.newState);
    _playAnimation();
  }

  void _playAnimation() {
    _setUpAnimation();
    _controller.forward();
  }
}