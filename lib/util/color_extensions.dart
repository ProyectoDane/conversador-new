import 'dart:ui';

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) =>
  Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

/// Construct a hex code string from a color, in the format #RRGGBB.
String colorToHex(Color color) {
  final String red = color.red.toRadixString(16).padLeft(2, '0');
  final String blue = color.blue.toRadixString(16).padLeft(2, '0');
  final String green = color.green.toRadixString(16).padLeft(2, '0');
  return '#$red$green$blue';
}