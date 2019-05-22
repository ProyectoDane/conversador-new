import 'package:flutter/material.dart';

/// For identifying whether or not device is a tablet
bool isDeviceTablet = false;

/// Preload device data
/// This function has to be called with a context within a 
/// materialApp or a widgetApp
void setDeviceData(BuildContext context) {
  // The number 600 here is a common breakpoint for a typical 7-inch tablet.
  // Source: https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts/
  final double shortestSide = MediaQuery.of(context).size.shortestSide;
  isDeviceTablet = shortestSide > 600;
}