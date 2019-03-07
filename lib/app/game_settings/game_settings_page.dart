import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_event.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/color_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/shape_difficulty.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/buttons/custom_button.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/images/custom_image.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/text/custom_text.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

class GameSettingsPage extends StatelessWidget {
  final GameSettingsBloc _bloc;

  GameSettingsPage(this._bloc);

  @override
  Widget build(BuildContext context) => PlatformScaffold(
        title: LangLocalizations.of(context).trans('settings_game_title'),
        body: _GameSettingsBody(_bloc),
      );
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
  Widget build(BuildContext context) => BlocBuilder<GameSettingsEvent, GameSettingsState>(
        bloc: widget.bloc,
        builder: (BuildContext context, GameSettingsState state) => _render(state),
      );

  Widget _render(final GameSettingsState state) {
    if (state is InitialState) {
      _toRender = _renderInitial();
    }

    if (state is ErrorState) {
      _toRender = _renderError(state);
    }

    return _toRender;
  }

  Widget _renderInitial() => Container(
        constraints: BoxConstraints.expand(),
        decoration: WidgetUtils.getBackground('assets/images/all/background.png'),
        child: SafeArea(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 1, child: _getTitleAndButton()),
            Expanded(flex: 2, child: _getImages()),
          ],
        )),
      );

  Widget _getTitleAndButton() => Container(
        margin: const EdgeInsets.only(bottom: Dimen.SPACING_NORMAL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getTitle(),
            _getButton(),
          ],
        ),
      );

  Widget _getTitle() => Container(
        margin: const EdgeInsets.only(right: Dimen.SPACING_NORMAL),
        child: CustomText(
          text: LangLocalizations.of(context).trans('game_settings_title'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimen.FONT_HUGE,
          ),
        ),
      );

  Widget _getButton() => CustomButton(
        onPressed: _submitWithDifficulties,
        text: LangLocalizations.of(context).trans('game_settings_start'),
      );

  Widget _getImages() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child: _getShapeImage()),
          Expanded(flex: 1, child: _getColorImage()),
        ],
      );

  Widget _getShapeImage() => GestureDetector(
        onTap: () => setState(() => hasShape = !hasShape),
        child: Container(
          margin: EdgeInsets.only(
            left: Dimen.SPACING_BIG,
            right: Dimen.SPACING_SMALL,
            bottom: Dimen.SPACING_BIG,
          ),
          child: CustomImage(
            imageUri: 'assets/images/game_settings/shapes.png',
            isActive: hasShape,
          ),
        ),
      );

  Widget _getColorImage() => GestureDetector(
        onTap: () => setState(() => hasColor = !hasColor),
        child: Container(
          margin: EdgeInsets.only(
            left: Dimen.SPACING_SMALL,
            right: Dimen.SPACING_BIG,
            bottom: Dimen.SPACING_BIG,
          ),
          child: CustomImage(
            imageUri: 'assets/images/game_settings/colors.png',
            isActive: hasColor,
          ),
        ),
      );

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

  Widget _renderError(final ErrorState state) => Center(child: Text(state.errorMessage));
}
