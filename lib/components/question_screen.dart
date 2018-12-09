import 'package:crystal/components/question_view.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  PageController _controller = new PageController();

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
    return Column(
      children: <Widget>[
        _Dots(controller: _controller, itemCount: questions.length),
        Container(
          child: _questionScreens(questions),
        ),
      ],
    );
  }

  Widget _questionScreens(List<Question> questions) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          child: PageView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            children: List<Widget>.from(
              questions.map((q) => QuestionView(
                question: q,
                onNext: () {},
              ))
            ),
          ),
        ),
      ],
    );
  }
}

class _Dots extends AnimatedWidget {
  final PageController controller;
  final int itemCount;

  _Dots({this.controller, this.itemCount}) : super(listenable: controller);

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    bool isSelected = controller.page == index;
    Color color = isSelected ? Colors.orange[200] : Colors.orange[100];
    return Container(
      color: color,
      width: 20.0,
      height: 10.0,
    );
  }
}
