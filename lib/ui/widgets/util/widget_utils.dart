import 'package:flutter/material.dart';

class WidgetUtils {
  static Decoration getBackground(final String imageUri) => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUri),
          fit: BoxFit.cover,
        ),
      );
}
