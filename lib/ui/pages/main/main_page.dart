import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape/shape_config.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/LangLocalizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO use bloc
   // _setDifficulty();

    return PlatformScaffold(
      title: LangLocalizations.of(context).trans('main_title'),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text(LangLocalizations.of(context).trans('main_start_game')),
            onPressed: () => Navigator.pushNamed(context, '/game'),
          ),
        ),
      ),
    );
  }

 // void _setDifficulty() => ShapeConfig.applyDifficulties([]);
}
