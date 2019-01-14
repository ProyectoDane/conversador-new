import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';

class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {
  final title;
  final body;
  final key;

  PlatformScaffold({@required this.title, @required this.body, this.key}) : super(key);

  @override
  Scaffold buildAndroidWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
    );
  }

  @override
  CupertinoPageScaffold buildIOSWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(title)),
      child: body,
    );
  }
}
