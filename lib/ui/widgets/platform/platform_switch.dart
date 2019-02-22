import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';

class PlatformSwitch extends PlatformBase<CupertinoSwitch, Switch> {
  final Key key;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeTrackColor;
  final Color activeColor;

  PlatformSwitch({
    @required this.value,
    @required this.onChanged,
    @required this.activeColor,
    this.activeTrackColor,
    this.key,
  }) : super(key);

  @override
  Switch buildAndroidWidget(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: activeTrackColor,
      activeColor: activeColor,
    );
  }

  @override
  CupertinoSwitch buildIOSWidget(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );
  }
}
