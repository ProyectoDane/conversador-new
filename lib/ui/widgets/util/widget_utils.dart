import 'package:flutter/material.dart';

class WidgetUtils {
  static Decoration getBackground(final String imageUri) => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUri),
          fit: BoxFit.fill,
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
