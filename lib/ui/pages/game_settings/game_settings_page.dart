import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/game_settings/game_settings_event.dart';
import 'package:flutter_syntactic_sorter/blocs/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_switch.dart';

class GameSettingsPage extends StatelessWidget {
  final GameSettingsBloc _bloc;

  GameSettingsPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: LangLocalizations.of(context).trans('settings_game_title'),
      body: _GameSettingsBody(_bloc),
    );
  }
}

class _GameSettingsBody extends StatefulWidget {
  final GameSettingsBloc bloc;

  _GameSettingsBody(this.bloc);

  @override
  State createState() => _GameSettingsBodyState();
}

class _GameSettingsBodyState extends State<_GameSettingsBody> {
  Widget _toRender;
  bool hasColor = true;
  bool hasShape = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSettingsEvent, GameSettingsState>(
      bloc: widget.bloc,
      builder: (BuildContext context, GameSettingsState state) => _render(state),
    );
  }

  Widget _render(GameSettingsState state) {
    if (state is InitialState) {
      _toRender = _renderInitial();
    }

    if (state is ErrorState) {
      _toRender = _renderError(state);
    }

    return _toRender;
  }

  Widget _renderInitial() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformSwitch(
              value: hasColor,
              onChanged: (value) => setState(() => hasColor = value),
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
            Material(
              child: Text(LangLocalizations.of(context).trans('game_settings_switch_color')),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformSwitch(
              value: hasShape,
              onChanged: (value) => setState(() => hasShape = value),
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
            Material(
              child: Text(LangLocalizations.of(context).trans('game_settings_switch_shape')),
            )
          ],
        ),
        RaisedButton(
          child: Text(LangLocalizations.of(context).trans('game_settings_play')),
          onPressed: _submitWithDifficulties,
        ),
      ],
    );
  }

  void _submitWithDifficulties() {
    final List<GameDifficulty> difficulties = [];
    if (!hasColor) {
      difficulties.add(ColorDifficulty());
    }
    if (!hasShape) {
      difficulties.add(ShapeDifficulty());
    }
    // TODO use events if possible
    widget.bloc.setDifficulty(difficulties).whenComplete(() => Navigator.pushNamed(context, Router.GAME_PAGE));
  }

  Widget _renderError(ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }
}
