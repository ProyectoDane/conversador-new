import 'package:flutter/material.dart';

/// Utilities for Widgets
/// (for Decorations or Assets)
class WidgetUtils {
  /// BoxDecoration for the given image to _fill_ the background.
  static Decoration getBackgroundImage(final String imageUri) => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUri),
          fit: BoxFit.fill,
        ),
      );

  /// BoxDecoration for a background with the specified color
  /// _containing_ the given image.
  static Decoration getColoredBackgroundWith(
          final Color color, final String imageUri) =>
      BoxDecoration(
        color: color,
        image: DecorationImage(
          image: AssetImage(imageUri),
          fit: BoxFit.contain,
        ),
      );

  /// Image widget for the given image,
  /// the optionally given color
  /// and the given fit (scaleDown by default)
  static Image getImage(final String imageUri,
          {final Color color, final BoxFit fit = BoxFit.scaleDown}) =>
      Image(
        image: AssetImage(imageUri),
        fit: fit,
        color: color,
      );
}
