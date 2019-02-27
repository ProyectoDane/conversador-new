import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUri;

  CustomImage({@required this.imageUri});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(const Radius.circular(30.0)),
        ),
        child: Image(
          image: AssetImage(imageUri),
          width: 300.0,
          height: 200.0,
        ),
      );
}
