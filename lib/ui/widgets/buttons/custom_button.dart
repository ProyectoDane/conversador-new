import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Button with white background and green text and border
class CustomButton extends StatelessWidget {
  /// Creates a CustomButton with the onPressed callback and the specified text
  const CustomButton(
      {@required this.onPressed,
      @required this.text,
      this.mainColor = Colors.lightGreen,
      this.secondaryColor = Colors.white,
      this.coloredBackground = false,
      this.fontSize = Dimen.FONT_LARGE});

  /// Callback for when the button is pressed
  final void Function() onPressed;

  /// Text in the button
  final String text;

  /// Font size for text
  final double fontSize;

  /// Whether the background should have the main color
  /// or the border and text.
  final bool coloredBackground;

  /// Button's main color
  final Color mainColor;

  /// Button's secondary color
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) => ButtonTheme(
        minWidth: 150,
        height: 50,
        child: RaisedButton(
          color: coloredBackground ? mainColor : secondaryColor,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
                color: coloredBackground ? secondaryColor : mainColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                color: coloredBackground ? secondaryColor : Colors.lightGreen,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      );
}
