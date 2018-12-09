import 'package:crystal/locale/locales.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/question.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/me/me_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class QuestionView extends StatefulWidget {
  final Question question;
  final Function onNext;

  QuestionView({Key key, this.question, this.onNext}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  List<Emoji> _selected;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) => _Props.fromStore(store),
        builder: (context, props) => _presenter(props.addEmoji, props.addEmojis));
  }

  Widget _presenter(Function addEmoji, Function addEmojis) {
    return Builder(
      builder: (context) => Scaffold(
            body: Center(
                child: Column(
              children: <Widget>[Text(widget.question.question), _emojis()],
            )),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _onPressed(context, addEmoji, addEmojis),
              child: Icon(Icons.arrow_forward),
            ),
          ),
    );
  }

  Widget _emojis() {
    return Container(
      child: Row(
        children: <Widget>[
          Column(children: List<Widget>.from(widget.question.emojis.map(_emoji))),
        ],
      ),
    );
  }

  Widget _emoji(Emoji emoji) {
    Function onTap = widget.question.isMulti
        ? () {
            if (_selected.contains(emoji)) {
              _selected.remove(emoji);
              setState(() => _selected = _selected);
            } else {
              _selected.add(emoji);
              setState(() => _selected = _selected);
            }
          }
        : () {
            setState(() {
              _selected = [emoji];
            });
          };
    return InkWell(
      onTap: onTap,
      child: Container(color: _selected.contains(emoji) ? Colors.orange : Colors.grey, child: emoji.getImage())
    );
  }

  void _onPressed(BuildContext context, Function addEmoji, Function addEmojis) {
    if (widget.question.isMulti) {
      // and selected.length != 3
      _snack(context, AppLocalizations.of(context).selectThreeError);
      return;
    } else if (widget.question.isLast) {
      // replace with selected.length != 1
      _snack(context, AppLocalizations.of(context).selectThreeError);
      return;
    }
    if (widget.question.isMulti)
      addEmojis(_selected);
    else
      addEmoji(_selected[0]);

    if (widget.question.isLast) {
      // todo navigate to results
    } else {
      widget.onNext();
    }
  }

  _snack(context, text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class _Props {
  final Function addEmoji;
  final Function addEmojis;

  _Props({
    this.addEmoji,
    this.addEmojis,
  });

  static fromStore(Store<AppState> store) {
    return _Props(
      addEmoji: (emoji) => store.dispatch(AddEmoji(emoji)),
      addEmojis: (emojis) => store.dispatch(AddEmojis(emojis)),
    );
  }
}
