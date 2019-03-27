import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';

class PlatformSwitch extends PlatformBase<CupertinoSwitch, Switch> {

  const PlatformSwitch({
    @required this.value,
    @required this.onChanged,
    @required this.activeColor,
    this.activeTrackColor,
    Key key
  }) : super(key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeTrackColor;
  final Color activeColor;

  @override
  Switch buildAndroidWidget(final BuildContext context) =>
    Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: activeTrackColor,
      activeColor: activeColor,
    );

  @override
  CupertinoSwitch buildIOSWidget(final BuildContext context) =>
    CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );

}
