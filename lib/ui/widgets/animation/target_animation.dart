import 'package:flutter/material.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';

class TargetAnimation extends StatefulWidget {
  final String label;
  final Color color;

  TargetAnimation({@required this.label, @required this.color});

  @override
  State<StatefulWidget> createState() => _TargetAnimationState();
}

class _TargetAnimationState extends State<TargetAnimation> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> transitionTween;
  Animation<BorderRadius> borderRadius;

  @override
  void initState() {
    super.initState();
    setUpAnimation();
  }

  void setUpAnimation() {
    _controller = AnimationController(duration: const Duration(milliseconds: Box.ANIMATION_DURATION_MS), vsync: this)
      ..addStatusListener((status) {});

    transitionTween = Tween<double>(begin: Box.TARGET_BOX_SIZE_START, end: Box.TARGET_BOX_SIZE_COMPLETE).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    borderRadius =
        BorderRadiusTween(begin: BorderRadius.circular(Box.TARGET_BOX_SIZE_COMPLETE), end: BorderRadius.circular(5.0))
            .animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
        );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(child: Container(width: Box.TARGET_BOX_SIZE, height: Box.TARGET_BOX_SIZE, color: Colors.black12)),
              Center(
                child: Container(
                  width: transitionTween.value,
                  height: transitionTween.value,
                  decoration: BoxDecoration(color: widget.color, borderRadius: borderRadius.value),
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 15.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}