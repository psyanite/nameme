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
import 'package:crystal/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

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
  Name name;
  String enBio;
  String localeBio;
  String languageCode;

  _Presenter({this.me, this.clearMe});

  @override
  Widget build(BuildContext context) {
    languageCode = Localizations.localeOf(context).languageCode;
    if (me.gender == null) return Scaffold();
    return FutureBuilder<Name>(
      future: getRandomName(me.gender.name),
      builder: (context, AsyncSnapshot<Name> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Scaffold();
          case ConnectionState.done:
            if (snapshot.hasError) return Scaffold();
            name = snapshot.data;
            enBio = Util.getBio(me, name.name, 'en');
            localeBio = languageCode != 'en' ? Util.getBio(me, name.name, languageCode) : null;
            return _content(context);
        }
      });
  }

  Widget _content(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(height: 10.0),
            _name(context),
            _bio(),
            _emojis(),
            _buttons(context),
          ],
        ),
      ));
  }

  Widget _name(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(AppLocalizations
          .of(context)
          .nameDesc, style: TextStyle(fontWeight: Burnt.fontLight)),
        Container(height: 10.0),
        Text(name.name, style: TextStyle(fontSize: 55.0, fontWeight: Burnt.fontLight)),
        Container(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(name.meaning, textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: Burnt.fontBold)),
        )
      ],
    );
  }

  Widget _bio() {
    getChildren(BuildContext context) {
      var children = <Widget>[
        Text(AppLocalizations.of(context).bioDesc, style: TextStyle(fontWeight: Burnt.fontLight)),
        Container(height: 10.0),
        Text(enBio, textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: Burnt.fontBold)),
      ];
      if (localeBio != null) {
        children.add(Container(height: 10.0));
        children.add(Text(localeBio, textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: Burnt.fontBold)));
      }
      return children;
    }
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: getChildren(context))));
  }

  Widget _emojis() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_emoji(me.animal), _emoji(me.food), _emoji(me.drink), _emoji(me.scenery)]),
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
    var locale = AppLocalizations.of(context);
    return Column(
      children: <Widget>[
        BigButton(
          text: locale.shareButton,
          onPressed: () => _share(locale.shareMessage),
          fontColor: Colors.white,
          isGradient: true,
        ),
        BigButton(
          text: locale.goAgainButton,
          onPressed: () {
            clearMe();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          },
          borderColor: Burnt.primary,
          fontColor: Burnt.primary,
        ),
      ],
    );
  }

  void _share(String template) {
    var url = 'https://raw.githubusercontent.com/psyanite/crystal/master/app/assets/img/demo.jpg';
    var message = template.replaceAll(":name:", name.name).replaceAll(":meaning:", name.meaning).replaceAll(":en-bio:", enBio).replaceAll(":locale-bio:", localeBio);
    message = '$message \n\n $url';
    Share.share(message);
  }

  Future<Name> getRandomName(String gender) async {
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
