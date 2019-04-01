import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Button with white background and green text and border
class CustomButton extends StatelessWidget {

  /// Creates a CustomButton with the onPressed callback and the specified text
  const CustomButton({@required this.onPressed, @required this.text});

  /// Callback for when the button is pressed
  final void Function() onPressed;
  /// Text in the button
  final String text;


  @override
  Widget build(BuildContext context) => ButtonTheme(
        minWidth: 250,
        height: 50,
        child: RaisedButton(
          color: Colors.white,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.lightGreen),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.lightGreen,
              fontSize: Dimen.FONT_LARGE,
            ),
          ),
        ),
      );
}
