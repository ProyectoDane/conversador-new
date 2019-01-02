import 'dart:io' show Platform;

import 'package:flutter/material.dart';

abstract class PlatformBase<I extends Widget, A extends Widget> extends StatelessWidget {
  final Key _key;

  PlatformBase(this._key) : super(key: _key);

  @override
  Widget build(BuildContext context) => Platform.isIOS ? buildIOSWidget(context) : buildAndroidWidget(context);

  I buildIOSWidget(BuildContext context);

  A buildAndroidWidget(BuildContext context);
}
