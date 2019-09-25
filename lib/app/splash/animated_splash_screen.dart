import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/util/device_type_helper.dart';

/// A Splash Screen that animates the logo enlarging it
class AnimatedSplashScreen extends StatefulWidget {
  /// Creates an AnimatedSplashScreen with the given information.
  /// - animationDuration is 2 seconds by default,
  /// - transitionDuration is 2.5 seconds by default,
  /// - backgroundColor is white by default.
  const AnimatedSplashScreen(
      {@required this.logoUri,
      @required this.homePageRouteName,
      this.animationDuration = const Duration(milliseconds: 2000),
      this.transitionDuration = const Duration(milliseconds: 2500),
      this.backgroundColor = Colors.white,
      this.poweredByLogoUri});

  /// The duration of the enlarging animation
  final Duration animationDuration;

  /// The duration until transitioning to home screen
  final Duration transitionDuration;

  /// Uri for the logo image
  final String logoUri;

  /// Uri for the powered by logo image, if any
  final String poweredByLogoUri;

  /// Route to the app's Home Page,
  /// so it will transition to it afterwards.
  final String homePageRouteName;

  /// Color of the background
  final Color backgroundColor;

  @override
  SplashScreenState createState() => SplashScreenState(
      animationDuration: animationDuration,
      transitionDuration: transitionDuration,
      logoUri: logoUri,
      poweredByLogoUri: poweredByLogoUri,
      homePageRouteName: homePageRouteName,
      backgroundColor: backgroundColor);
}

/// State for Splash screen
class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  /// Creates a SplashScreenState based on information.
  SplashScreenState(
      {@required Duration animationDuration,
      @required Duration transitionDuration,
      @required String logoUri,
      @required String poweredByLogoUri,
      @required String homePageRouteName,
      @required Color backgroundColor})
      : _animationDuration = animationDuration,
        _transitionDuration = transitionDuration,
        _logoUri = logoUri,
        _poweredByLogoUri = poweredByLogoUri,
        _homePageRouteName = homePageRouteName,
        _backgroundColor = backgroundColor;

  final Duration _animationDuration;
  final Duration _transitionDuration;
  final String _logoUri;
  final String _poweredByLogoUri;
  final String _homePageRouteName;
  final Color _backgroundColor;

  AnimationController _animationController;
  Animation<double> _animation;

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
    _animationController =
        AnimationController(duration: _animationDuration, vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      _startTime();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setDeviceData(context);

    return Scaffold(
          body: Container(
        color: _backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (_poweredByLogoUri != null)
              ? <Widget>[_getLogoWidget(false), _getPoweredByWidget()]
              : <Widget>[_getLogoWidget(true)],
        ),
      ));
      }

  Widget _getPoweredByWidget() => Expanded(
        flex: 1,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Image.asset(
              _poweredByLogoUri,
              fit: BoxFit.scaleDown,
            )),
      );

  Widget _getLogoWidget(bool onlyWidget) => Expanded(
      flex: 2,
      child: Builder(builder: (BuildContext context) {
        final double size = min(
            min(MediaQuery.of(context).size.height * (onlyWidget ? 1 : 2 / 3),
                MediaQuery.of(context).size.width),
            250);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget child) => Image.asset(
                    _logoUri,
                    width: _animation.value * size,
                    height: _animation.value * size,
                  ),
            )
          ],
        );
      }));
}
