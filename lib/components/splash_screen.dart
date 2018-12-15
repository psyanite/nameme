import 'dart:async';

import 'package:crystal/components/home_screen.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/me/me_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  final Function setDpi;

  SplashScreen({this.setDpi});

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() async {
    return Timer(
      Duration(seconds: 3),
        () {
        widget.setDpi(MediaQuery
          .of(context)
          .textScaleFactor);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function>(
      converter: (Store<AppState> store) => (mediaQuery) => store.dispatch(SetMediaData(mediaQuery)),
      builder: (BuildContext context, Function setMediaQuery) => _content(context, setMediaQuery));
  }

  _content(BuildContext context, Function setMediaQuery) {
    setMediaQuery(MediaQuery.of(context));
    return Scaffold(
      body: Container(
        child: Center(child: Text('NameMe', style: TextStyle(color: Colors.white, fontFamily: Burnt.fontFancy, fontSize: 70.0))),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1.0],
            colors: [Burnt.gradientYellow, Burnt.gradientPink],
          ))));
  }
}
