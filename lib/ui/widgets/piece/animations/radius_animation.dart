import 'package:flutter/material.dart';

/// Animation for turning a widget into another
class SizeAnimation {
  /// Returns a Widget that can overlap a Container on top of a Widget,
  /// animating the size of the back one so you can see it
  /// appearing (or disappearing).
  static Widget animate({
    @required final Animation<double> sizeAnimation,
    @required final CustomPainter backPainter,
    @required final Widget frontChild,
  }) =>
      AnimatedBuilder(
        animation: sizeAnimation,
        builder: (BuildContext context, Widget child) => Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CustomPaint(
                    painter: backPainter,
                    child: Container(
                      height: sizeAnimation.value,
                      width: sizeAnimation.value,
                    ),
                  ),
                  frontChild,
                ],
              ),
            ),
      );
}
