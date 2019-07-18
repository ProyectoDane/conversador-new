import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';
import 'package:flutter_syntactic_sorter/util/device_type_helper.dart';

/// Button with text. Default color settings is
/// white background and green text and border
class CustomButton extends _AppCustomButton {
  /// Creates a CustomButton with the onPressed callback and the specified text
  CustomButton(
      {@required Function() onPressed,
      @required this.text,
      Color mainColor = Colors.lightGreen,
      Color secondaryColor = Colors.white,
      bool coloredBackground = false,
      this.fontSize = 0,
      double minWidth = 150,
      double height = 50}) : super(
    onPressed: onPressed, 
    mainColor: mainColor, 
    secondaryColor: secondaryColor,
    coloredBackground: coloredBackground,
    minWidth: minWidth,
    height: height);

  /// Text in the button
  final String text;

  /// Font size for text
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final double defautSize = isDeviceTablet ? Dimen.FONT_HUGE:Dimen.FONT_LARGE;
    final double chosenFontSize = fontSize == 0 ? defautSize:fontSize;

    return ButtonTheme(
        minWidth: minWidth,
        height: height,
        child: RaisedButton(
          color: getRaisedButtonColor(),
          onPressed: onPressed,
          shape: getRectagleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                color: getInnerItemColor(),
                fontSize: chosenFontSize,
              ),
            ),
          ),
        ),
      );}
}

/// Button with icon. Default color settings is
/// white background and green text and border
class CustomIconButton extends _AppCustomButton {
  /// Creates a CustomButton with the onPressed callback and the specified icon
  CustomIconButton({
    @required Function() onPressed,
    @required this.iconData,
    Color mainColor = Colors.lightGreen,
    Color secondaryColor = Colors.white,
    bool coloredBackground = false,
    double minWidth = 60,
    double height = 50
  }) : super(
    onPressed: onPressed, 
    mainColor: mainColor, 
    secondaryColor: secondaryColor,
    coloredBackground: coloredBackground,
    minWidth: minWidth,
    height: height);

  /// Data for icon creation
  final IconData iconData;

  @override
  Widget build(BuildContext context) 
    => ButtonTheme(
        minWidth: minWidth,
        height: height,
        child: RaisedButton(
          color: getRaisedButtonColor(),
          onPressed: onPressed,
          shape: getRectagleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Icon(
              iconData, 
              size: Dimen.ICON_DEFAULT_SIZE, 
              color: getInnerItemColor(),),
          ),
        ),
    );
}

class _AppCustomButton extends StatelessWidget {
  const _AppCustomButton(
    {@required this.onPressed,
    this.mainColor,
    this.secondaryColor,
    this.coloredBackground,
    this.minWidth,
    this.height});

  /// Callback for when the button is pressed
  final void Function() onPressed;

  /// Whether the background should have the main color
  /// or the border and text.
  final bool coloredBackground;

  /// Button's main color
  final Color mainColor;

  /// Button's secondary color
  final Color secondaryColor;

  /// Button's minimum width
  final double minWidth;

  /// Button's height
  final double height;

  @protected
  Color getRaisedButtonColor () =>
    coloredBackground ? mainColor : secondaryColor;

  @protected
  RoundedRectangleBorder getRectagleBorder() =>
    RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
                color: coloredBackground ? secondaryColor : mainColor),
          );

  @protected
  Color getInnerItemColor () =>
    coloredBackground ? secondaryColor : Colors.lightGreen;

  @override
  Widget build(BuildContext context) => null;
  
}
