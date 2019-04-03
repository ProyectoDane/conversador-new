import 'dart:io' show Platform;

import 'package:flutter/material.dart';

/// Base class for developing and Widget component that
/// should look differently in iOS and Android.
abstract class PlatformBase<I extends Widget, A extends Widget>
    extends StatelessWidget {

  /// Creates a PlatformBased widget.
  const PlatformBase(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? buildIOSWidget(context)
      : buildAndroidWidget(context);

  /// Returns the widget to use when in iOS device
  I buildIOSWidget(final BuildContext context);

  /// Returns the widget to use when in Android device
  A buildAndroidWidget(final BuildContext context);
}
