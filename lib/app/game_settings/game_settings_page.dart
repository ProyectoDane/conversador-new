import 'dart:io' show Platform;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_stage_selection_helper.dart';
import 'package:flutter_syntactic_sorter/app/game_settings/game_settings_state.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/game_difficulty.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/buttons/custom_button.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/images/custom_image.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/text/custom_text.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_syntactic_sorter/util/device_type_helper.dart';

/// Page for GameSettings
/// GameModeDifficulty selection (activation and deactivation).
/// Also, it moves on to next screen.
class GameSettingsPage extends StatelessWidget {
  /// Creates the Page based on the GameSettingsBloc
  const GameSettingsPage(this._bloc);

  final GameSettingsBloc _bloc;

  @override
  Widget build(BuildContext context) => PlatformScaffold(
        title: LangLocalizations.of(context).trans('settings_game_title'),
        body: _GameSettingsBody(_bloc),
      );
}

class _GameSettingsBody extends StatefulWidget {
  const _GameSettingsBody(this.bloc);
  final GameSettingsBloc bloc;

  @override
  State<StatefulWidget> createState() => _SettingsBodyState(bloc);
}

class _SettingsBodyState extends State<_GameSettingsBody> {
  _SettingsBodyState(this.bloc);
  final GameSettingsBloc bloc;

  @override
  void initState() {
    super.initState();
    widget.bloc.viewWasShown();
  }

  @override
  Widget build(BuildContext context) 
  => BlocProvider<GameSettingsBloc>(
    builder: (BuildContext context) => bloc,
    child: BlocBuilder<GameSettingsBloc, GameSettingsState>(
      builder: _render,
    ),
  );
  
  Widget _render(BuildContext context, GameSettingsState state) => Container(
        constraints: const BoxConstraints.expand(),
        decoration:
            WidgetUtils.getBackgroundImage('assets/images/all/background.png'),
        child: SafeArea(
            child: Stack(
              children: <Widget>[
                _getSettingsInterface(context, state),
                state.isShowingStages ? 
                  _getStageSelection(context, state.stages):Container()],
            )),
      );

  //------------------------------------------------------
  // Settings interface
  //------------------------------------------------------

  Widget _getSettingsInterface(BuildContext context, GameSettingsState state) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (Platform.isIOS) ? 
            const Padding(padding: EdgeInsets.only(top: 50),):Container(),
          Expanded(flex: 1, child: _getTitleAndButton(context, state)),
          Expanded(flex: 2, child: _getImages(state.difficulties)),
        ],
    );

  Widget _getTitleAndButton(BuildContext context, GameSettingsState state) => 
    Container(
        margin: const EdgeInsets.only(
          bottom: Dimen.SPACING_NORMAL, 
          left: Dimen.SPACING_NORMAL, 
          right:Dimen.SPACING_NORMAL),
        child:Row(
            children: <Widget>[
              _getTitle(context),
              _getStartButton(context),
              const Padding(padding: EdgeInsets.only(
                left: Dimen.SPACING_SMALL),),
              _getLevelSelectButton(context, state),
            ],
          ),
        
      );

  Widget _getTitle(BuildContext context) => Expanded(
    child:Container(
      child: CustomText(
        text: LangLocalizations.of(context)
            .trans('game_settings_title')
            .toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isDeviceTablet ? Dimen.FONT_HUGE : Dimen.FONT_BIG,
        ),
      ),
      )
    );

  Widget _getStartButton(BuildContext context) => CustomButton(
        onPressed: () => _submitWithDifficulties(context),
        text: LangLocalizations.of(context)
            .trans('game_settings_start')
            .toUpperCase(),
      );

  Widget _getLevelSelectButton(BuildContext context, GameSettingsState state) =>
      CustomIconButton(
        iconData: Icons.list, 
        onPressed: () {
          if (state.stages != null) {
            bloc.toggleStagesVisibility();
          }
        },
      );

  Widget _getImages(List<Tuple2<GameModeDifficulty, bool>> difficulties) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: difficulties
          .map((Tuple2<GameModeDifficulty, bool> tuple) => Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => bloc.tappedOnDifficulty(tuple.item1),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: Dimen.SPACING_SMALL,
                      right: Dimen.SPACING_SMALL,
                      bottom: Dimen.SPACING_BIG,
                    ),
                    // The image represents the hint, the difficulty
                    // is the lack of what the image shows:
                    child: CustomImage(
                      imageUri: tuple.item1.imageUri,
                      textDescription: LangLocalizations
                        .of(context)
                        .trans(tuple.item1.textDescription)
                        .toUpperCase() ,
                      isActive: !tuple.item2,
                    ),
                  ),
                ),
              ))
          .toList());

  void _submitWithDifficulties(BuildContext context) {
    StageSelection().lastStagePlayed = null;
    bloc
        .saveDifficulties()
        .whenComplete(() => Navigator.pushNamed(context, Router.GAME_PAGE));
  }

  //------------------------------------------------------
  // Settings interface
  //------------------------------------------------------

  Widget _getStageSelection(BuildContext context, List<Stage> stages) {
    const double margin = 10;
    final double appBarHeight = AppBar().preferredSize.height;
    final double topMargin = Platform.isIOS ? appBarHeight:margin;

    return Container(
      margin: EdgeInsets.only(
        top:topMargin, bottom: margin, left:margin, right: margin),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow:const <BoxShadow>[BoxShadow(
            color: Colors.black,
            offset: Offset(5, 5),
            blurRadius: 10,
          )]
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            LangLocalizations.of(context).trans('select_phrase')),          
          leading: FlatButton.icon(
            onPressed: bloc.toggleStagesVisibility,
            label: const Text(''),
            icon: const Icon(Icons.close, 
                        size: Dimen.ICON_SMALL_SIZE, 
                        color:Colors.white),),
            backgroundColor: Colors.lightGreen,
          ),
        body: ListView.separated(
          separatorBuilder: (_, int index) => Divider(
            color: Colors.grey,
          ),
          itemCount: stages.length,
          itemBuilder: (_, int index) {
            final Stage stage = stages[index];
            return _getStageTile(stage);
          }),
      )
    );
  }

  ListTile _getStageTile(Stage stage) 
    => ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: WidgetUtils.getImage(stage.backgroundUri),
      ),
      title: CustomText(
        text: stage.stageSentenceString,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: isDeviceTablet ? 
            Dimen.FONT_HUGE : Dimen.FONT_LARGE,
          )
        ),
      trailing: const Icon(
                Icons.navigate_next, 
                size: Dimen.ICON_DEFAULT_SIZE, 
                color: Colors.black,),
      onTap: () {
        StageSelection().stageSelection = stage.id;
        _submitWithDifficulties(context);
        bloc.toggleStagesVisibility();
      },
  );
}
