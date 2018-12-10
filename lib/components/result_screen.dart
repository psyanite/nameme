import 'dart:math';

import 'package:crystal/components/home_screen.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/models/emoji.dart';
import 'package:crystal/models/name.dart';
import 'package:crystal/presentation/components.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/me/me_actions.dart';
import 'package:crystal/state/me/me_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) => _Props.fromStore(store),
      builder: (context, props) => _Presenter(me: props.me, clearMe: props.clearMe));
  }
}

class _Presenter extends StatelessWidget {
  final MeState me;
  final Function clearMe;

  _Presenter({this.me, this.clearMe});

  @override
  Widget build(BuildContext context) {
    if (me.gender == null) return Scaffold();
    return FutureBuilder<Name>(
        future: getRandomName(me.gender.name, Localizations.localeOf(context).languageCode),
        builder: (context, AsyncSnapshot<Name> name) {
          switch (name.connectionState) {
               case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Scaffold();
                case ConnectionState.done:
                  if (name.hasError) return Scaffold();
                  return _content(context, name.data);
              }
        });
  }

  Widget _content(BuildContext context, Name name) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(height: 10.0),
            _name(context, name),
//            _bio(),
            _emojis(me),
            _buttons(context),
          ],
        ),
      ));
  }

  Widget _name(BuildContext context, Name name) {
    return Column(
      children: <Widget>[
        Text(AppLocalizations.of(context).nameDesc),
        Container(height: 10.0),
        Text(name.name, style: TextStyle(fontSize: 55.0)),
        Container(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(name.meaning, textAlign: TextAlign.center),
        )
      ],
    );
  }

  Widget _bio() {
    // todo: generate bio
    return Builder(
        builder: (context) => Column(children: <Widget>[
              Text(AppLocalizations.of(context).bioDesc),
              Text('bio'),
            ]));
  }

  Widget _emojis(MeState me) {
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_emoji(me.blood), _emoji(me.animal), _emoji(me.drink), _emoji(me.scenery)]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_emoji(me.weather), _emoji(me.extras[0]), _emoji(me.extras[1]), _emoji(me.extras[2])]),
      ],
    );
  }

  Widget _emoji(Emoji emoji) {
    return Padding(padding: EdgeInsets.all(5.0), child: emoji.getImage(scale: 4.0));
  }

  Widget _buttons(BuildContext context) {
    return Column(
      children: <Widget>[
        // get button text from localization
        BigButton(
          text: AppLocalizations.of(context).shareButton,
          onPressed: () {},
          fontColor: Colors.white,
          isGradient: true,
        ),
        BigButton(
          text: AppLocalizations.of(context).goAgainButton,
          onPressed: () {
            clearMe();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          },
          borderColor: Burnt.gradientPink,
          fontColor: Burnt.gradientPink,
        ),
      ],
    );
  }

  Future<Name> getRandomName(String gender, String languageCode) async {
    final lines = (await rootBundle.loadString('assets/names/$gender.csv')).split('\n');
    var details = lines[Random().nextInt(lines.length - 2) + 1].split('","');
    var meaning;
    switch (languageCode) {
      case 'en':
        meaning = details[1];
        break;
      case 'ko':
        meaning = details[2];
        break;
      case 'ja':
        meaning = details[3].replaceAll('\"\r', '');
        break;
    }
    return Name(
      name: details[0].replaceAll('"', ''),
      meaning: meaning,
    );
  }
}

class _Props {
  final MeState me;
  final Function clearMe;

  _Props({this.me, this.clearMe});

  static fromStore(Store<AppState> store) {
    return _Props(
      me: store.state.me,
      clearMe: () => store.dispatch(ClearMe()),
    );
  }
}
