import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_widget.dart';
import 'package:flutter_syntactic_sorter/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/buttons/custom_button.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';
import 'package:sprintf/sprintf.dart';

/// Page for the Game part.
/// It shows the stage image on the background and loads
/// the LiveStageWidget for the current stage's current level.
class GamePage extends StatelessWidget {
  /// Creates a GamePage with a GameBloc.
  const GamePage(this._bloc);

  final GameBloc _bloc;

  @override
  Widget build(BuildContext context) => PlatformScaffold(
        body: _GameBody(_bloc),
      );
}

class _GameBody extends StatefulWidget {
  const _GameBody(this.bloc);

  final GameBloc bloc;

  @override
  State createState() => _GameBodyState();
}

class _GameBodyState extends State<_GameBody> {
  @override
  void initState() {
    super.initState();
    widget.bloc.viewWasShown();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GameEvent, GameState>(
      bloc: widget.bloc,
      builder: (BuildContext context, GameState state) {
        if (state.levelCompleted != null) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => _showDialog(
                state.levelCompleted, state.isFinalLevel, context));
        }
        return _render(state);
      });

  void _showDialog(int level, bool isFinalLevel, BuildContext context) {
    // The levels start from 0, so 1 is added to the regular message.
    final String regularBody = sprintf(
      LangLocalizations.of(context).trans(
        'game.level_ended_pop_up.body'),<int>[level+1]).toUpperCase();
    final String finalBody = LangLocalizations.of(context).trans(
        'game.level_ended_pop_up.last_body').toUpperCase();
        
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text(LangLocalizations.of(context)
                .trans('game.level_ended_pop_up.title').toUpperCase()),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(isFinalLevel ? finalBody:regularBody),
                  const SizedBox(height: Dimen.SPACING_NORMAL),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomButton(
                          text: LangLocalizations.of(context)
                              .trans('game.level_ended_pop_up.no')
                              .toUpperCase(),
                          fontSize: Dimen.FONT_NORMAL,
                          coloredBackground: false,
                          onPressed: () {
                            Navigator.of(context).popUntil(
                                (Route<dynamic> route) =>
                                    route.settings.name == Router.MAIN_PAGE);
                          },
                        ),
                        CustomButton(
                          text: LangLocalizations.of(context)
                              .trans('game.level_ended_pop_up.yes')
                              .toUpperCase(),
                          fontSize: Dimen.FONT_NORMAL,
                          coloredBackground: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.bloc.continueToNextLevel();
                          },
                        ),
                      ])
                ])));
  }

  Widget _render(final GameState state) => Center(
      child: (state.loading) ? _getLoadingWidget() : _getLiveStage(state));
  
  Widget _getLoadingWidget() =>
    Container(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        color: Colors.transparent,
      );

  Widget _getLiveStage(GameState state) =>
    Stack(
      key: UniqueKey(),
      children: <Widget>[
        Container(
          decoration: WidgetUtils.getColoredBackgroundWith(
                  Colors.white, state.backgroundUri),
          child: LiveStageWidget(state.liveStageBloc, state.isStageCompleted)),
        state.isStageCompleted ? _getEndStageButtons():Container()
      ],
    );

  Widget _getEndStageButtons()
    => Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(
          right: Dimen.SPACING_SMALL, bottom: Dimen.SPACING_SMALL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: Dimen.SPACING_NORMAL),
            ),
            CustomIconButton(
              imageUrl: 'assets/images/utils/play_sound_icon.png',
              onPressed: (){
                widget.bloc.replayPhraseSound();
              },),
            const Padding(
              padding: EdgeInsets.only(top: Dimen.SPACING_TINY),
            ),
            CustomIconButton(
              iconData: Icons.navigate_next,
              onPressed: (){
                widget.bloc.continueToNextStage();
              },)
          ],
        ),
      ),
    );
}
