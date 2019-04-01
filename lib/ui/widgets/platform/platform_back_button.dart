import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';

/// Back button that only appears in iOS, since
/// Android has the native back button.
class PlatformBackButton extends PlatformBase<Widget, Widget> {

  /// Creates a PlatformBackButton
  const PlatformBackButton({Key key}) : super(key);

  @override
  Widget buildAndroidWidget(final BuildContext context) =>
    const SizedBox();

  @override
  Widget buildIOSWidget(final BuildContext context) {
    const double size = 35;
    final ModalRoute<dynamic> route = ModalRoute.of(context);
    final Color iconColor = Theme.of(context).iconTheme.color;
    final String imageUri = route is PageRoute && route.fullscreenDialog
        ? 'assets/images/utils/close_icon.png'
        : 'assets/images/utils/back_arrow_icon.png';
    const Color color = Colors.lightGreen;
    final Widget child = Navigator.of(context).canPop() ? Align(
      alignment: Alignment.topLeft,
      child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(size),
          ),
          child: RaisedButton(
            onPressed: (){ Navigator.pop(context); },
            child: WidgetUtils.getImage(imageUri, color: iconColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size)
            ),
            color: color,
            padding: const EdgeInsets.all(10),
          ),
      ),
    ) : const SizedBox();
    return child;
  }
}