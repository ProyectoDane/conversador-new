import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/blocs/cards/cards_event.dart';
import 'package:flutter_cards/blocs/cards/cards_state.dart';
import 'package:flutter_cards/ui/widgets/platform/platform_scaffold.dart';

class CardsPage extends StatelessWidget {
  final CardsBloc _bloc;

  CardsPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(title: 'Words', child: CardsBody(bloc: _bloc));
  }
}

class CardsBody extends StatefulWidget {
  final CardsBloc bloc;

  CardsBody({@required this.bloc});

  @override
  _CardsBodyState createState() => _CardsBodyState();
}

class _CardsBodyState extends State<CardsBody> {
  bool _error(CardsState state) => state.errorMessage != null;

  bool _success(CardsState state) => state.word != null;

  @override
  void initState() {
    super.initState();
    widget.bloc.loadWord();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsEvent, CardsState>(
      bloc: widget.bloc,
      builder: (BuildContext context, CardsState state) {
        Widget toRender = _renderInitial();
        if (_error(state)) {
          toRender = _renderError(state);
        }
        if (_success(state)) {
          toRender = _renderSuccess(state);
        }
        return toRender;
      },
    );
  }

  Widget _renderInitial() => Container();

  Widget _renderError(CardsState state) => Center(child: Text(state.errorMessage));

  Widget _renderSuccess(CardsState state) {
    return Container(
      color: state.word.color,
      child: Center(
        child: Text(state.word.value),
      ),
    );
  }
}
