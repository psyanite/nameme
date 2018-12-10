import 'package:crystal/components/question_view.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/question.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  PageController _controller = new PageController();

  final dotContainerHeight = 50.0;

  List<Question> getQuestions(BuildContext context) {
    return [
      Question(question: AppLocalizations.of(context).genderQuestion, emojis: Emoji.genders),
      Question(question: AppLocalizations.of(context).bloodQuestion, emojis: Emoji.bloods),
      Question(question: AppLocalizations.of(context).foodQuestion, emojis: Emoji.food),
      Question(question: AppLocalizations.of(context).animalQuestion, emojis: Emoji.animals),
      Question(question: AppLocalizations.of(context).weatherQuestion, emojis: Emoji.weather),
      Question(question: AppLocalizations.of(context).drinkQuestion, emojis: Emoji.drinks),
      Question(question: AppLocalizations.of(context).sceneryQuestion, emojis: Emoji.sceneries),
      Question(question: AppLocalizations.of(context).extrasQuestion, emojis: Emoji.extras, isLast: true, isMulti: true),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var questions = getQuestions(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          _Dots(controller: _controller, itemCount: questions.length, height: dotContainerHeight),
          Container(
            height: MediaQuery
              .of(context)
              .size
              .height - dotContainerHeight,
            child: _questionScreens(questions),
          ),
        ],
      ));
  }

  Widget _questionScreens(List<Question> questions) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: List<Widget>.from(questions.map((q) =>
              QuestionView(
                question: q,
                onNext: () {
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
            gradient: isSelected ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1.0],
              colors: [Burnt.gradientYellow, Burnt.gradientPink],
            ) : null)),
      ),
    );
  }
}