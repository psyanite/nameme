import 'package:crystal/components/loading_screen.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/question.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/me/me_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class QuestionView extends StatelessWidget {
  final Question question;
  final Function goToPreviousPage;
  final Function goToNextPage;

  QuestionView({Key key, this.question, this.goToPreviousPage, this.goToNextPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) => _Props.fromStore(store, question),
        builder: (context, props) => _Presenter(
              addEmoji: props.addEmoji,
              addEmojis: props.addEmojis,
              selected: props.selected,
              question: question,
              goToPreviousPage: goToPreviousPage,
              goToNextPage: goToNextPage,
            ));
  }
}

class _Presenter extends StatefulWidget {
  final Function addEmoji;
  final Function addEmojis;
  final List<Emoji> selected;
  final Question question;
  final Function goToPreviousPage;
  final Function goToNextPage;

  _Presenter({this.addEmoji, this.addEmojis, this.selected, this.question, this.goToPreviousPage, this.goToNextPage});

  @override
  _PresenterState createState() => _PresenterState();
}

class _PresenterState extends State<_Presenter> {
  Function addEmoji;
  Function addEmojis;
  List<Emoji> selected;
  Question question;
  Function goToPreviousPage;
  Function goToNextPage;

  @override
  initState() {
    super.initState();
    addEmoji = widget.addEmoji;
    addEmojis = widget.addEmojis;
    selected = widget.selected;
    question = widget.question;
    goToPreviousPage = widget.goToPreviousPage;
    goToNextPage = widget.goToNextPage;
  }

  @override
  Widget build(BuildContext context) {
    var children = List<Widget>.from([
      Column(
        children: <Widget>[Text(question.question, style: TextStyle(fontWeight: Burnt.fontBold)), Container(height: 20.0), _emojis()],
      )
    ]);
    if (question.emojis.length < 8) children.add(Container(height: 70.0));
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
      floatingActionButton: question.isFirst ? null : _fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      onPressed: () => goToPreviousPage(),
      child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1.0],
                colors: [Burnt.gradientYellow, Burnt.gradientPink],
              )),
          child: Icon(Icons.arrow_back, color: Colors.white)),
    );
  }

  Widget _emojis() {
    var emojis = question.emojis;
    List<Widget> rows = List<Widget>();
    for (var i = 0; i < emojis.length / 2; i++) {
      rows.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        _emoji(emojis[i * 2]),
        _emoji(emojis[i * 2 + 1]),
      ]));
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ),
    );
  }

  Widget _emoji(Emoji emoji) {
    Function onTap = question.isMulti
        ? () {
            if (selected.contains(emoji)) {
              selected.remove(emoji);
              setState(() => selected = selected);
            } else {
              selected.add(emoji);
              setState(() => selected = selected);
              if (selected.length == 3) {
                addEmojis(selected);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoadingScreen()),
                );
              }
            }
          }
        : () {
            selected.add(emoji);
            setState(() => selected = selected);
            addEmoji(emoji);
            goToNextPage();
          };
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: emoji.getImage(),
            decoration: BoxDecoration(
                color: selected.contains(emoji) ? null : Color(0xFFEEEEEE),
                shape: BoxShape.circle,
                gradient: selected.contains(emoji)
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 1.0],
                        colors: [Burnt.gradientYellow, Burnt.gradientPink],
                      )
                    : null)),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}

class _Props {
  final Function addEmoji;
  final Function addEmojis;
  final List<Emoji> selected;

  _Props({this.addEmoji, this.addEmojis, this.selected});

  static fromStore(Store<AppState> store, Question question) {
    List<Emoji> selected = List<Emoji>();
    switch (question.emojis[0].type) {
      case EmojiType.Animal:
        selected = store.state.me.animal != null ? [store.state.me.animal] : List<Emoji>();
        break;
      case EmojiType.Blood:
        selected = store.state.me.blood != null ? [store.state.me.blood] : List<Emoji>();
        break;
      case EmojiType.Drink:
        selected = store.state.me.drink != null ? [store.state.me.drink] : List<Emoji>();
        break;
      case EmojiType.Extra:
        selected = store.state.me.extras ?? List<Emoji>();
        break;
      case EmojiType.Food:
        selected = store.state.me.food != null ? [store.state.me.food] : List<Emoji>();
        break;
      case EmojiType.Gender:
        selected = store.state.me.gender != null ? [store.state.me.gender] : List<Emoji>();
        break;
      case EmojiType.Scenery:
        selected = store.state.me.scenery != null ? [store.state.me.scenery] : List<Emoji>();
        break;
      case EmojiType.Weather:
        selected = store.state.me.weather != null ? [store.state.me.weather] : List<Emoji>();
        break;
      default:
        return List<Emoji>();
        break;
    }

    return _Props(
      selected: selected,
      addEmoji: (emoji) => store.dispatch(AddEmoji(emoji)),
      addEmojis: (emojis) => store.dispatch(AddEmojis(emojis)),
    );
  }
}
