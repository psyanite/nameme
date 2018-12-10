import 'dart:async';

';
import 'package:crystal/components/result_screen.dart';
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
        () =>
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ResultScreen()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1.0],
            colors: [Burnt.gradientYellow, Burnt.gradientPink],
          ))));
  }
}
