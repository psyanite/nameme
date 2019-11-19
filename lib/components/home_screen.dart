import 'package:crystal/components/question_screen.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/presentation/components.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseAnalytics>(
      converter: (Store<AppState> store) => store.state.me.analytics,
      builder: (context, analytics) => _presenter(context, analytics),
      rebuildOnChange: false,
    );
  }

  Widget _presenter(BuildContext context, FirebaseAnalytics analytics) {
    analytics.setCurrentScreen(screenName: "home_screen");
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
                text: AppLocalizations.of(context).startButton,
                onPressed: () => _goToQuestionOne(context),
                color: Colors.white,
                fontColor: Burnt.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _landingPrompt(BuildContext context) {
    var locale = AppLocalizations.of(context);
    List<String> texts = [locale.landingPrompt1];
    if (locale.landingPrompt2 != null) texts.add(locale.landingPrompt2);
    if (locale.landingPrompt3 != null) texts.add(locale.landingPrompt3);
    return Column(
      children: List<Widget>.from(
        texts.map(
          (t) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              t,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _goToQuestionOne(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => QuestionScreen()),
    );
  }
}
