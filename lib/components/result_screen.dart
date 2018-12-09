import 'package:crystal/locale/locales.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/question.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/me/me_state.dart';
import 'package:crystal/utils/enum_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ResultScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) => store.state.me,
      builder: (context, me) => _presenter(me));
  }

  Widget _presenter(MeState me) {
    // todo generate name and meaning
    return Builder(
      builder: (context) =>
        Column(
          children: <Widget>[
            Text(AppLocalizations
              .of(context)
              .nameDesc),
            _name('Emily'),
            _nameMeaning('meaning'),
            _bio(),
            _emojis(me),
            _buttons(),
          ],
        ),
    );
  }

  Widget _name(String name) {
    return Text(name);
  }

  Widget _nameMeaning(String name) {
    return Text(name);
  }

  Widget _bio() {
    // todo generate bio
    return Builder(
      builder: (context) =>
        Column(
          children: <Widget>[
            Text(AppLocalizations
              .of(context)
              .bioDesc),
            Text('bio'),
          ]
        )
    );
  }

  Widget _emojis(MeState me) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          me.blood.getImage(), me.animal.getImage(), me.drink.getImage(), me.scenery.getImage()
        ]),
        Row(children: <Widget>[
          me.weather.getImage(), me.extras[0].getImage(), me.extras[1].getImage(), me.extras[2].getImage()
        ]),
      ],
    );
  }

  Widget _buttons() {
    return Column(
      children: <Widget>[
        // get button text from localization
        FlatButton(child: Text('Share'), onPressed: () {}),
        FlatButton(child: Text('Go again'), onPressed: () {}),
      ],
    );
  }
}
