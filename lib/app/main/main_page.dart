import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/ui/router.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/buttons/custom_button.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/text/custom_text.dart';
import 'package:flutter_syntactic_sorter/ui/widgets/util/widget_utils.dart';
import 'package:flutter_syntactic_sorter/util/dimen.dart';

/// HomePage of the app.
/// First screen, waits for user confirmation to continue.
class MainPage extends StatelessWidget {

  /// Creates the main page.
  const MainPage();

  @override
  Widget build(BuildContext context) =>
      const PlatformScaffold(
          body: _MainBody()
      );
}

class _MainBody extends StatelessWidget {

  const _MainBody();

  @override
  Widget build(BuildContext context) => Container(
        constraints: const BoxConstraints.expand(),
        decoration: WidgetUtils.getBackgroundImage('assets/images/all/background.png'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getTitle(context),
            _getButton(context),
          ],
        ),
      );

  Widget _getTitle(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: Dimen.SPACING_NORMAL),
        child: CustomText(
          text: LangLocalizations.of(context).trans('main_title'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimen.FONT_HUGE,
          ),
        ),
      );

  Widget _getButton(BuildContext context) => CustomButton(
        onPressed: () =>
            Navigator.pushNamed(context, Router.GAME_SETTINGS_PAGE),
        text: LangLocalizations.of(context).trans('main_btn_start'),
      );

}
