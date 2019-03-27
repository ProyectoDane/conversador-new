import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_bloc.dart';
import 'package:flutter_syntactic_sorter/app/game/game_event.dart';
import 'package:flutter_syntactic_sorter/app/game/game_state.dart';
import 'package:flutter_syntactic_sorter/app/game/live_stage/live_stage_widget.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';

class GamePage extends StatelessWidget {
  const GamePage(this._bloc);

  final GameBloc _bloc;

  @override
  Widget build(BuildContext context) =>
    PlatformScaffold(
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
  Widget build(BuildContext context) =>
    BlocBuilder<GameEvent, GameState>(
      bloc: widget.bloc,
      builder: (BuildContext context, GameState state) => _render(state),
    );

  Widget _render(final GameState state) => Center(
    child: (state.loading)
        ? const CircularProgressIndicator()
        : Container(
            decoration: WidgetUtils.getColoredBackgroundWith(
                Colors.white,
                state.backgroundUri
            ),
            child: LiveStageWidget(state.liveStageBloc)
          )
  );

}
