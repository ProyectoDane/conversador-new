import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: 'Game',
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("START GAME"),
            onPressed: () => Navigator.pushNamed(context, '/game'),
          ),
        ),
      ),
    );
  }
}
