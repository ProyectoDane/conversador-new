import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_event.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_state.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';

class MainPage extends StatelessWidget {
  final MainBloc _bloc;

  MainPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: LangLocalizations.of(context).trans('main_title'),
      body: _MainBody(_bloc),
    );
  }
}

class _MainBody extends StatefulWidget {
  final MainBloc bloc;

  _MainBody(this.bloc);

  @override
  State createState() => _MainBodyState();
}

class _MainBodyState extends State<_MainBody> {
  Widget _toRender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainEvent, MainState>(
      bloc: widget.bloc,
      builder: (BuildContext context, MainState state) => _render(state),
    );
  }

  Widget _render(MainState state) {
    if (state is InitialState) {
      _toRender = _renderInitial();
    }

    if (state is ErrorState) {
      _toRender = _renderError(state);
    }

    return _toRender;
  }

  Widget _renderInitial() {
    return Center(
      child: RaisedButton(
          child: Text(LangLocalizations.of(context).trans('main_start_game')),
          onPressed: () => Navigator.pushNamed(context, Router.GAME_SETTINGS_PAGE)),
    );
  }

  Widget _renderError(ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }
}
