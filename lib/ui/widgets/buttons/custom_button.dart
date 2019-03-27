import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

class CustomButton extends StatelessWidget {

  const CustomButton({@required this.onPressed, @required this.text});

  final void Function() onPressed;
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
