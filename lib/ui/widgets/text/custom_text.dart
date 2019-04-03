import 'package:flutter/material.dart';

/// Wrapper for a Text to avoid weird bugs.
/// It wraps it in Material of type .transparency
class CustomText extends StatelessWidget {

  /// Creates a custom text based on its text and its style (optional)
  const CustomText({@required this.text, this.style});

  /// Text of the widget
  final String text;
  /// Style of the etxt (optional)
  final TextStyle style;

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Text(
          text,
          style: style,
        ),
      );
}
