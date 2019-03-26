import 'package:flutter/material.dart';

class WidgetUtils {
  static Decoration getBackgroundImage(final String imageUri) => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUri),
          fit: BoxFit.fill,
        ),
      );

  static Decoration getColoredBackgroundWith(final Color color, final String imageUri) => BoxDecoration(
    color: color,
    image: DecorationImage(
      image: AssetImage(imageUri),
      fit: BoxFit.contain,
    ),
  );

  static Image getImage(final String imageUri,
      {final Color color,
      final BoxFit fit = BoxFit.scaleDown}) => Image(
    image: AssetImage(imageUri),
    fit: fit,
    color: color,
  );
}
