import 'package:crystal/components/question_view.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/question.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/utils/util.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseAnalytics>(
        converter: (Store<AppState> store) => store.state.me.analytics,
        builder: (context, analytics) => _Presenter(analytics: analytics),
        rebuildOnChange: false);
  }
}

class _Presenter extends StatefulWidget {
  final FirebaseAnalytics analytics;

  _Presenter({this.analytics});

  @override
  _PresenterState createState() => _PresenterState();
}

class _PresenterState extends State<_Presenter> {
  PageController _controller = new PageController();
  BannerAd _bannerAd;

  final double _dotContainerHeight = 50.0;
  final double _bannerAdHeight = 50.0;

  List<Question> getQuestions(BuildContext context) {
    return [
      Question(question: AppLocalizations.of(context).genderQuestion, emojis: Emoji.genders, isFirst: true),
      Question(question: AppLocalizations.of(context).bloodQuestion, emojis: Emoji.bloods),
      Question(question: AppLocalizations.of(context).foodQuestion, emojis: Emoji.food),
      Question(question: AppLocalizations.of(context).animalQuestion, emojis: Emoji.animals),
      Question(question: AppLocalizations.of(context).weatherQuestion, emojis: Emoji.weather),
      Question(question: AppLocalizations.of(context).drinkQuestion, emojis: Emoji.drinks),
      Question(question: AppLocalizations.of(context).sceneryQuestion, emojis: Emoji.sceneries),
      Question(question: AppLocalizations.of(context).extrasQuestion, emojis: Emoji.extras, isMulti: true),
    ];
  }

  @override
  void initState() {
    super.initState();
    widget.analytics.setCurrentScreen(screenName: "question_screen");
    _bannerAd = Util.buildBannerAd()..load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bannerAd..show();
    var questions = getQuestions(context);
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              _Dots(controller: _controller, itemCount: questions.length, height: _dotContainerHeight),
              Expanded(child: _questionScreens(questions)),
            ],
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: _bannerAdHeight),
      color: Burnt.paper,
    );
  }

  Widget _questionScreens(List<Question> questions) {
    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: List<Widget>.from(questions.map((q) => QuestionView(
                  question: q,
                  goToPreviousPage: () {
                    _controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  goToNextPage: () {
                    _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                  },
                ))),
          ),
        ),
      ],
    );
  }
}

class _Dots extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final double height;

  _Dots({this.controller, this.itemCount, this.height}) : super(listenable: controller);

  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, _buildDot),
      ),
    );
  }

  void _onTap(int index) {
    if (controller.page >= index) {
      controller.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  Widget _buildDot(int index) {
    bool isSelected = controller.hasClients ? index <= controller.page : index <= controller.initialPage;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        onTap: () => _onTap(index),
        child: Container(
            width: 30.0,
            height: 10.0,
            decoration: BoxDecoration(
                color: isSelected ? null : Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(5.0),
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 1.0],
                        colors: [Burnt.gradientYellow, Burnt.gradientPink],
                      )
                    : null)),
      ),
    );
  }
}
