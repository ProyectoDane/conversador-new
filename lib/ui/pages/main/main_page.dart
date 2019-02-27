import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_bloc.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_event.dart';
import 'package:flutter_syntactic_sorter/blocs/main/main_state.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/buttons/custom_button.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

class MainPage extends StatelessWidget {
  final MainBloc _bloc;

  MainPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(body: _MainBody(_bloc));
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
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: Dimen.SPACING_NORMAL),
            child: Text(
              LangLocalizations.of(context).trans('main_title'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimen.FONT_HUGE,
              ),
            ),
          ),
          CustomButton(
            onPressed: () => Navigator.pushNamed(context, Router.GAME_SETTINGS_PAGE),
            text: LangLocalizations.of(context).trans('main_btn_start'),
          )
        ],
      ),
    );
  }

  Widget _renderError(ErrorState state) {
    return Center(child: Text(state.errorMessage));
  }
}
