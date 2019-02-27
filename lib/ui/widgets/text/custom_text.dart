import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;

  CustomText({@required this.text, this.style});

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Text(
          text,
          style: style,
        ),
      );
}
