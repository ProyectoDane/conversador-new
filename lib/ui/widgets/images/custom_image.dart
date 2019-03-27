import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {

  const CustomImage({@required this.imageUri, @required this.isActive});

  final String imageUri;
  final bool isActive;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.lightGreen,
            width: isActive ? 10 : 0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Image(
          image: AssetImage(imageUri),
          width: 300,
          height: 200,
        ),
      );
}
