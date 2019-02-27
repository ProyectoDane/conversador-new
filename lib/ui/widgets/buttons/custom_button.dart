import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  CustomButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) => ButtonTheme(
        minWidth: 250.0,
        height: 50.0,
        child: RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: onPressed,
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
