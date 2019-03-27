import 'dart:io' show Platform;

import 'package:flutter/material.dart';

abstract class PlatformBase<I extends Widget, A extends Widget>
    extends StatelessWidget {

  const PlatformBase(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? buildIOSWidget(context)
      : buildAndroidWidget(context);

  I buildIOSWidget(final BuildContext context);

  A buildAndroidWidget(final BuildContext context);
}
