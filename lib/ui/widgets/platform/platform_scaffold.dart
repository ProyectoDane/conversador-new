import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_back_button.dart';

class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {
  final Widget body;
  final String title;
  final bool enableBack;
  final Key key;

  PlatformScaffold({@required this.body, this.title, this.enableBack, this.key}) : super(key);

  @override
  Scaffold buildAndroidWidget(final BuildContext context) {
    final bar = title == null ? null : AppBar(title: Text(title));
    return Scaffold(appBar: bar, body: body);
  }

  @override
  CupertinoPageScaffold buildIOSWidget(final BuildContext context) {
    final bool backEnabled = enableBack ?? true;
    if (title != null) {
      final bar = CupertinoNavigationBar(
          middle: Text(title),
          automaticallyImplyLeading: backEnabled,
      );
      return CupertinoPageScaffold(navigationBar: bar, child: body);
    } else if (backEnabled) {
      return CupertinoPageScaffold(
          navigationBar: null,
          child: Stack(children: [
            new Positioned(child: body),
            new Positioned(child: PlatformBackButton())
          ])
      );
    } else {
      return CupertinoPageScaffold(navigationBar: null, child: body);
    }

  }
}
