import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';

class PlatformBackButton extends PlatformBase<Widget, Widget> {
  final Key key;

  PlatformBackButton({this.key}) : super(key);

  @override
  Widget buildAndroidWidget(final BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildIOSWidget(final BuildContext context) {
    final size = 35.0;
    final route = ModalRoute.of(context);
    final iconColor = Theme.of(context).iconTheme.color;
    final imageUri = route is PageRoute && route.fullscreenDialog ? 'assets/images/utils/close_icon.png' : 'assets/images/utils/back_arrow_icon.png';
    final color = Colors.lightGreen;
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
            onPressed: (){ Navigator.pop(context); return true; },
            child: WidgetUtils.getImage(imageUri, color: iconColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size)),
            color: color,
            padding: const EdgeInsets.all(10.0),
          ),
      ),
    ) : SizedBox();
//    return Container(
//      margin: EdgeInsets.all(10),
//      child: child,
//    );
    return child;
  }
}