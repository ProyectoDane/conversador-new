import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cards/blocs/cards/cards_bloc.dart';
import 'package:flutter_cards/ui/pages/cards/cards_page.dart';

class CardsApp extends StatelessWidget {
  final _cardsBloc = CardsBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'Flutter Cards',
      theme: ThemeData(),
      routes: {
        '/': (BuildContext context) => CardsPage(_cardsBloc),
      },
    );
  }
}
