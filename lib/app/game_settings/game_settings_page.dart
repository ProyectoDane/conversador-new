import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_event.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/buttons/custom_button.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/images/custom_image.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/text/custom_text.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';
import 'package:tuple/tuple.dart';

class GameSettingsPage extends StatelessWidget {
  final GameSettingsBloc _bloc;

  GameSettingsPage(this._bloc);

  @override
  Widget build(BuildContext context) => PlatformScaffold(
        title: LangLocalizations.of(context).trans('settings_game_title'),
        body: _GameSettingsBody(_bloc),
      );
}

class _GameSettingsBody extends StatelessWidget {
  final GameSettingsBloc bloc;

  _GameSettingsBody(this.bloc);

  @override
  Widget build(BuildContext context) => BlocBuilder<GameSettingsEvent, GameSettingsState>(
    bloc: bloc,
    builder: (BuildContext context, GameSettingsState state) => _render(context, state),
  );

  Widget _render(BuildContext context, GameSettingsState state) => Container(
        constraints: BoxConstraints.expand(),
        decoration: WidgetUtils.getBackgroundImage('assets/images/all/background.png'),
        child: SafeArea(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 1, child: _getTitleAndButton(context)),
            Expanded(flex: 2, child: _getImages(state.difficulties)),
          ],
        )),
      );

  Widget _getTitleAndButton(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: Dimen.SPACING_NORMAL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getTitle(context),
            _getButton(context),
          ],
        ),
      );

  Widget _getTitle(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: Dimen.SPACING_NORMAL),
        child: CustomText(
          text: LangLocalizations.of(context).trans('game_settings_title'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimen.FONT_HUGE,
          ),
        ),
      );

  Widget _getButton(BuildContext context) => CustomButton(
        onPressed: () => _submitWithDifficulties(context),
        text: LangLocalizations.of(context).trans('game_settings_start'),
      );

  Widget _getImages(List<Tuple2<GameDifficulty, bool>> difficulties) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: difficulties.map((tuple) => Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => bloc.tappedOnDifficulty(tuple.item1),
        child: Container(
          margin: EdgeInsets.only(
            left: Dimen.SPACING_BIG,
            right: Dimen.SPACING_SMALL,
            bottom: Dimen.SPACING_BIG,
          ),
          // The image represents the hint, the difficulty
          // is the lack of what the image shows:
          child: CustomImage(
            imageUri: tuple.item1.imageUri,
            isActive: !tuple.item2,
          ),
        ),
      ),
    )).toList()
  );

  void _submitWithDifficulties(BuildContext context) {
    bloc.saveDifficulties().whenComplete(() => Navigator.pushNamed(context, Router.GAME_PAGE));
  }

}
