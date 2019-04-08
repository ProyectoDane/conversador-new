import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_widget.dart';
import 'package:flutter_syntactic_sorter/router.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';

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
              (_) => _showDialog(state.levelCompleted, context));
        }

        return _render(state);
      });

  void _showDialog(int levelNumber, BuildContext context) {
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text('Congratulations !'),
                content: Text('You have just finished level $levelNumber'
                    '. Want to continue practicing?'),
                actions: [
                  FlatButton(
                    child: const Text('No thanks'),
                    onPressed: () {
                      Navigator.of(context).popUntil((Route<dynamic> route) =>
                          route.settings.name == Router.MAIN_PAGE);
                    },
                  ),
                  FlatButton(
                    child: const Text('Yes!'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.bloc.continueToNextLevel();
                    },
                  ),
                ]));
  }

  Widget _render(final GameState state) => Center(
      child: (state.loading)
          ? const CircularProgressIndicator()
          : Container(
              decoration: WidgetUtils.getColoredBackgroundWith(
                  Colors.white, state.backgroundUri),
              child: LiveStageWidget(state.liveStageBloc)));
}
