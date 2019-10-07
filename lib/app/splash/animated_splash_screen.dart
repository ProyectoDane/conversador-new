import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/device_type_helper.dart';

/// A Splash Screen that animates the logo enlarging it
class AnimatedSplashScreen extends StatefulWidget {
  /// Creates an AnimatedSplashScreen with the given information.
  /// - transitionDuration is 2.5 seconds by default,
  const AnimatedSplashScreen(
      {@required this.backgroundLogoUri,
      @required this.homePageRouteName,
      this.transitionDuration = const Duration(milliseconds: 2500),
      this.poweredByLogoUri});

  /// The duration until transitioning to home screen
  final Duration transitionDuration;

  /// Uri for the logo image
  final String backgroundLogoUri;

  /// Uri for the powered by logo image, if any
  final String poweredByLogoUri;

  /// Route to the app's Home Page,
  /// so it will transition to it afterwards.
  final String homePageRouteName;

  @override
  SplashScreenState createState() => SplashScreenState(
      transitionDuration: transitionDuration,
      logoUri: backgroundLogoUri,
      poweredByLogoUri: poweredByLogoUri,
      homePageRouteName: homePageRouteName);
}

/// State for Splash screen
class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  /// Creates a SplashScreenState based on information.
  SplashScreenState(
      {
      @required Duration transitionDuration,
      @required String logoUri,
      @required String poweredByLogoUri,
      @required String homePageRouteName})
      : _transitionDuration = transitionDuration,
        _backgroundLogoUri = logoUri,
        _poweredByLogoUri = poweredByLogoUri,
        _homePageRouteName = homePageRouteName;

  final Duration _transitionDuration;
  final String _backgroundLogoUri;
  final String _poweredByLogoUri;
  final String _homePageRouteName;

  Timer _startTime() {
    final Duration _duration = _transitionDuration;
    return Timer(_duration, _navigationPage);
  }

  void _navigationPage() {
    Navigator.of(context).pushReplacementNamed(_homePageRouteName);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    setDeviceData(context);

    return Scaffold(
      body: Container(
        decoration: _getBackgroundImageDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _getEmptySpaceWidget(),
            _getPoweredByWidget()],
        ),
      ));
  }

  BoxDecoration _getBackgroundImageDecoration() => BoxDecoration(
    image: DecorationImage(
      image: AssetImage(_backgroundLogoUri),
      fit: BoxFit.cover)
    );

  Widget _getEmptySpaceWidget() => Expanded(
    child: Container(),
    );

  Widget _getPoweredByWidget() {
    final double sidePadding = isDeviceTablet ? 40:20;
    final double bottomPadding = isDeviceTablet ? 50:30;
        return Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding, left: sidePadding, right: sidePadding),
    child: Image.asset(
      _poweredByLogoUri,
      fit: BoxFit.scaleDown,
    ));
  }
}
