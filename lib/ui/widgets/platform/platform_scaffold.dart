import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cards/ui/widgets/platform/platform_base.dart';

class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {
  final String title;
  final Widget child;
  final Key key;

  PlatformScaffold({@required this.title, @required this.child, this.key}) : super(key);

  @override
  Scaffold buildAndroidWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
    );
  }

  @override
  CupertinoPageScaffold buildIOSWidget(BuildContext context) {
    return CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(middle: Text(title)), child: child);
  }
}
