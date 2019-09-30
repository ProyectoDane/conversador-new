import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/text/custom_text.dart';
import 'package:flutter_syntactic_sorter/util/device_type_helper.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Image that has an green inner border if active
class CustomImage extends StatelessWidget {

  /// Creates a CustomImage from the image uri
  /// and adds a border to it if isActive.
  const CustomImage(
    {@required this.imageUri, 
    @required this.textDescription,  
    @required this.isActive});

  /// Image uri
  final String imageUri;
  /// Is active (should have border) or not
  final bool isActive;
  /// Text description
  final String textDescription;

  @override
  Widget build(BuildContext context) 
    => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.lightGreen,
            width: isActive ? 10 : 0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Container(
          height: isDeviceTablet ? 330:200,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: isDeviceTablet ? 40:10),
              ),
              Expanded(
                child: Image(
                  image: AssetImage(imageUri),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: isDeviceTablet ? 40:10),
              ),
              CustomText(
                text: textDescription,
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: isDeviceTablet ? Dimen.FONT_LARGE:Dimen.FONT_NORMAL
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: isDeviceTablet ? 40:10),
              )
            ],
          ),
        ),
      );
}
