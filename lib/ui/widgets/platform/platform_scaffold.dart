import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_back_button.dart';

/// A scaffold wrapper that handles different
/// app bars, scaffolds and back button
/// based on the platform we are in.
class PlatformScaffold extends PlatformBase<CupertinoPageScaffold, Scaffold> {

  /// Creates a PlatformScaffold with:
  /// - a body to show
  /// - title to show in app bar (if wanted)
  /// - whether we should enable or not the back button
  const PlatformScaffold({
    @required this.body,
    this.title,
    this.enableBack,
    Key key
  }) : super(key);

  /// Body of the page/scaffold
  final Widget body;
  /// Title of the page, if there is any
  final String title;
  /// Whether we should show a back button or not.
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
