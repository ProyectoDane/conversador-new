import 'package:flutter/material.dart';

/// Animation for making a piece transparent and back to normal.
class OpacityAnimation {
  /// Returns a Widget that can animate opacity,
  /// of the given child Widget whenever the opacityAnimation
  /// starts animating (that is to say, starts sending values
  /// for the animation progress).
  /// The opacity widget animation is inverse to the opacityAnimation
  /// values (when the opacityAnimation sends 0.3, the widget
  /// will change to opacity 0.7).
  static Widget animate(
          {@required final Animation<double> opacityAnimation,
          @required final Widget childWidget}) =>
      AnimatedBuilder(
        animation: opacityAnimation,
        builder: (BuildContext context, Widget child) =>
          Opacity(
            opacity: 1 - opacityAnimation.value,
            child: childWidget,
            ),
      );
}
