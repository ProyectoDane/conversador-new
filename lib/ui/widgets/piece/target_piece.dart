import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece.dart';
import 'package:flutter_syntactic_sorter/model/piece/piece_config.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_state.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/opacity_animation.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/piece/animations/radius_animation.dart';

/// Static piece that serves as a target for the drag pieces.
/// It contains a string and can be configured by a PieceConfig.
class TargetPiece extends StatefulWidget {

  /// Creates a TargetPiece from
  /// - the piece to represent
  /// - the piece configuration to follow
  /// - the position where it should start (top left corner)
  /// - the visual state it's in (normal, warning or completed)
  /// - the Bloc to which to notify events.
  const TargetPiece({
    @required this.piece,
    @required this.pieceConfig,
    @required this.initPosition,
    @required this.visualState,
    @required this.bloc
  });

  static const int _ANIMATION_TIME_MS = 1500;
  static const int _ANIMATION_TIME_FAST_MS = _ANIMATION_TIME_MS ~/ 2;
  static const Duration _NORMAL = Duration(milliseconds: _ANIMATION_TIME_MS);
  static const Duration _FAST = Duration(milliseconds: _ANIMATION_TIME_FAST_MS);

  /// Piece which this represents
  final Piece piece;
  /// Configuration to mold the piece by
  final PieceConfig pieceConfig;
  /// Origin of the piece (top left corner)
  final Offset initPosition;
  /// The TargetPieceVisualState it should be in
  final TargetPieceVisualState visualState;
  /// Bloc to which to notify events
  final LiveStageBloc bloc;

  @override
  State<StatefulWidget> createState() => _TargetPieceState();
}

class _TargetPieceState
    extends State<TargetPiece>
    with TickerProviderStateMixin {

  _TargetPieceState();

  AnimationController _sizeController;
  AnimationController _opacityController;
  Animation<double> _sizeAnimation;
  Animation<double> _opacityAnimation;
  Widget _toRender;

  LiveStageBloc _bloc;
  Piece _piece;
  PieceConfig _pieceConfig;
  Offset _initPosition;
  TargetPieceVisualState _visualState;
  TargetPieceVisualState _oldVisualState;


  @override
  void initState() {
    super.initState();
    _setUpData();
    _setUpRender();
  }

  @override
  void didUpdateWidget(TargetPiece oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUpData();
    _setUpRender();
  }

  void _setUpData() {
    _visualState = widget.visualState;
    _initPosition = widget.initPosition;
    _pieceConfig = widget.pieceConfig;
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
    _sizeController = AnimationController(
        duration: TargetPiece._NORMAL,
        vsync: this
    );
    _sizeAnimation = Tween<double>(begin: 0, end: Piece.BASE_SIZE)
        .animate(_sizeController);
    _opacityController = AnimationController(
        duration: TargetPiece._FAST,
        vsync: this
    );
    _opacityAnimation = CurvedAnimation(
        parent: _opacityController,
        curve: Curves.decelerate
    );
  }

  @override
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
          _opacityController.forward()
              .whenComplete(_opacityController.reverse)
              .whenComplete((){ _bloc.completedWarningAnimation(_piece); });
          break;
        case TargetPieceVisualState.completed:
          _sizeController.forward()
              .whenComplete((){ _bloc.completedSuccessAnimation(_piece); });
          break;
      }
    }
    return _toRender;
  }

  Widget _renderInitial() => Positioned(
        left: _initPosition.dx,
        top: _initPosition.dy,
        child: DragTarget<Piece>(
            onWillAccept: (Piece piece) => piece.concept == _piece.concept,
            onAccept: (Piece piece) {
              _bloc.pieceSuccess(dragPiece: piece, targetPiece: _piece);
            },
            builder: (BuildContext context,
                List<Piece> accepted,
                List<dynamic> rejected) => _completedWidget(),
            ),
      );

  Widget _renderAnimated() => Positioned(
    left: _initPosition.dx,
    top: _initPosition.dy,
    child: _completedWidget(),
  );

  Widget _completedWidget() => OpacityAnimation.animate(
      opacityAnimation: _opacityAnimation,
      childWidget: SizeAnimation.animate(
        sizeAnimation: _sizeAnimation,
        backDecoration: _piece.buildDecoration(
            pieceType: Piece.TARGET_COMPLETED,
            pieceConfig: _pieceConfig),
        frontChild: _piece.buildWidget(
            pieceType: Piece.TARGET_INITIAL,
            pieceConfig: _pieceConfig),
      )
  );

}
