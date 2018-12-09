import 'dart:async';

import 'package:crystal/components/home_screen.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() async {
    return Timer(
        Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(child: Text('NameMe', style: TextStyle(fontFamily: Burnt.fontFancy, fontSize: 70.0))),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1.0],
              colors: [Burnt.gradientYellow, Burnt.gradientPink],
            ))));
  }
}
