import 'package:flutter/material.dart';

/// Image that has an green inner border if active
class CustomImage extends StatelessWidget {

  /// Creates a CustomImage from the image uri
  /// and adds a border to it if isActive.
  const CustomImage({@required this.imageUri, @required this.isActive});

  /// Image uri
  final String imageUri;
  /// Is active (should have border) or not
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
