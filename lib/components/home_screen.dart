import 'package:crystal/components/question_screen.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/presentation/components.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color(0xFF7F0CB1),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _landingPrompt(context),
                Container(height: 20.0),
                BigButton(
                  color: Colors.white,
                  fontColor: Burnt.gradientPink,
                  text: AppLocalizations.of(context).startButton,
                  onPressed: () => _goToQuestionOne(context),
                ),
              ],
            ))));
  }

  Widget _landingPrompt(BuildContext context) {
    var locale = AppLocalizations.of(context);
    List<String> texts = [locale.landingPrompt1];
    if (locale.landingPrompt2 != null) texts.add(locale.landingPrompt2);
    if (locale.landingPrompt3 != null) texts.add(locale.landingPrompt3);
    return Column(children: List<Widget>.from(texts.map((t) => Text(t))));
  }

  void _goToQuestionOne(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuestionScreen()),
    );
  }
}
