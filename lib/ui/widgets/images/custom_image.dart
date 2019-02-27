import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUri;
  final bool isActive;

  CustomImage({@required this.imageUri, @required this.isActive});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.lightGreen,
            width: isActive ? 10.0 : 0,
          ),
          borderRadius: BorderRadius.all(const Radius.circular(30.0)),
        ),
        child: Image(
          image: AssetImage(imageUri),
          width: 300.0,
          height: 200.0,
        ),
      );
}
