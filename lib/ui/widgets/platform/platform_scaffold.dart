import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';

class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {
  final Widget body;
  final String title;
  final Key key;

  PlatformScaffold({@required this.body, this.title, this.key}) : super(key);

  @override
  Scaffold buildAndroidWidget(final BuildContext context) {
    final bar = title == null ? null : AppBar(title: Text(title));
    return Scaffold(appBar: bar, body: body);
  }

  @override
  CupertinoPageScaffold buildIOSWidget(final BuildContext context) {
    final bar = title == null ? null : CupertinoNavigationBar(middle: Text(title));
    return CupertinoPageScaffold(navigationBar: bar, child: body);
  }
}
