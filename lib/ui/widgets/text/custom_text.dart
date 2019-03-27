import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  const CustomText({@required this.text, this.style});

  final String text;
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
