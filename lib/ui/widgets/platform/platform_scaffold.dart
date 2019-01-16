import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';

class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {
  final body;
  final title;
  final key;

  PlatformScaffold({@required this.body, this.title, this.key}) : super(key);

  @override
  Scaffold buildAndroidWidget(BuildContext context) {
    final appBar = title == null ? null : AppBar(title: Text(title));
    return Scaffold(appBar: appBar, body: body);
  }

  @override
  CupertinoPageScaffold buildIOSWidget(BuildContext context) {
    final navigationBar = title == null ? null : CupertinoNavigationBar(middle: Text(title));
    return CupertinoPageScaffold(navigationBar: navigationBar, child: body);
  }
}
