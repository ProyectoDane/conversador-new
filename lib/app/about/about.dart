import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/text/custom_text.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// Screen with about information of the app
class AboutScreen extends StatelessWidget {
  final TextStyle _titleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: Dimen.FONT_LARGE, 
    fontWeight: FontWeight.bold);

  final TextStyle _subTitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: Dimen.FONT_NORMAL, 
    fontWeight: FontWeight.w600);

  final TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: Dimen.FONT_NORMAL, 
    fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context)
    => Scaffold(
      appBar: AppBar(
        title: Text(LangLocalizations.of(context)
          .trans('main_title').toUpperCase()),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/splash/Dane_Logo.png',
              fit: BoxFit.contain,
              height: 80,
            ),
          ),
          _getTitleSegment(context, 'DANE'),
          _getTextSegment(context, 
            LangLocalizations.of(context).trans('about_review')),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_coordination_title')),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/splash/Tinc_Logo.png',
              fit: BoxFit.contain,
              height: 70,
            ),
          ),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_idea_content_title')),
          _getTextSegment(context, 'Bettina Schettini'),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_development_title')),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/splash/Intive_Logo.png',
              fit: BoxFit.contain,
              height: 70,
            ),
          ),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_thanks_title')),
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_developers_subtitle'), 
            style: _subTitleTextStyle),
          // ignore: lines_longer_than_80_chars
          _getTextSegment(context, 'Victorio Matteucci, Moises Apaza, Daniela Riesgo, Alberto Rojas, Agustin Palmeira, Ezequiel Gonzalez'),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_designers_subtitle'), 
            style: _subTitleTextStyle),
          _getTextSegment(context, 'Sandra Soledad Mari, Alexander Kalinowski'),
          _getTitleSegment(context, 
            LangLocalizations.of(context).trans('about_colaborators_subtitle'), 
            style: _subTitleTextStyle),
          // ignore: lines_longer_than_80_chars
          _getTextSegment(context, 'Nicolas Daneri Raffo, Nicolas Nieves, Isaias Ariel Montenegro, Juan Manuel Alvarez Gimenez, Valentina Berois, Mariano Stampella')
        ],
      ),
    );

  Widget _getTitleSegment(
    BuildContext context, String text, {TextStyle style}) 
    => Center(
      child: CustomText(
        text:text,
        style: style != null ? style : _titleTextStyle,
        ),
      );

  Widget _getTextSegment(BuildContext context, String text)
    => Center(
      child: Padding(
        padding: 
          const EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
        child: CustomText(
          text: text,
          style: _textStyle,
        ),
      ),
    );
}