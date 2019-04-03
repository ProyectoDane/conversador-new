import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_base.dart';

/// Switch that is Material design style in Android and Cupertino in iOS.
class PlatformSwitch extends PlatformBase<CupertinoSwitch, Switch> {

  /// Creates the switch with:
  /// - whether it should start on or off
  /// - a callback for when the value is changed
  /// - color of the switch when it's on
  /// - color of the track when the switch is on (optional)
  const PlatformSwitch({
    @required this.value,
    @required this.onChanged,
    @required this.activeColor,
    this.activeTrackColor,
    Key key
  }) : super(key);

  /// It's initial value [True if on]
  final bool value;
  /// Callback for when value changes.
  final ValueChanged<bool> onChanged;
  /// Color of the track when the switch is on (optional)
  final Color activeTrackColor;
  /// Color fo the switch when it's on.
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
