import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/device_type_helper.dart';

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
  Widget build(BuildContext context) {
    final double imagePadding = isDeviceTablet ? 90:0;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.lightGreen,
            width: isActive ? 10 : 0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        padding: EdgeInsets.only(left:imagePadding, right: imagePadding),
        child: Image(
          image: AssetImage(imageUri),
          width: 300,
          height: isDeviceTablet ? 300:200,
          fit: isDeviceTablet ? BoxFit.contain:BoxFit.none,
        ),
      );
    }
}
