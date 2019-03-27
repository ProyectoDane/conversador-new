import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_back_button.dart';

class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {

  const PlatformScaffold({
    @required this.body,
    this.title,
    this.enableBack,
    Key key
  }) : super(key);

  final Widget body;
  final String title;
  final bool enableBack;

  @override
  Scaffold buildAndroidWidget(final BuildContext context) {
    final AppBar bar = title == null ? null : AppBar(title: Text(title));
    return Scaffold(appBar: bar, body: body);
  }

  @override
  CupertinoPageScaffold buildIOSWidget(final BuildContext context) {
    final bool backEnabled = enableBack ?? true;
    if (title != null) {
      final CupertinoNavigationBar bar = CupertinoNavigationBar(
          middle: Text(title),
          automaticallyImplyLeading: backEnabled,
      );
      return CupertinoPageScaffold(navigationBar: bar, child: body);
    } else if (backEnabled) {
      return CupertinoPageScaffold(
          navigationBar: null,
          child: Stack(children: <Widget>[
            Positioned(child: body),
            const Positioned(child: PlatformBackButton(), left: 10, top: 10),
          ])
      );
    } else {
      return CupertinoPageScaffold(navigationBar: null, child: body);
    }

  }
}
