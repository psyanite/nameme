import 'dart:async';

import 'package:crystal/components/result_screen.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  InterstitialAd _interstitial;

  @override
  void dispose() {
    _interstitial.dispose();
    super.dispose();
  }

  _startTimer(BuildContext context) async {
    return Timer(Duration(seconds: 3), () {
      _interstitial = InterstitialAd(
//          adUnitId: InterstitialAd.testAdUnitId,
          adUnitId: 'ca-app-pub-6524279756456110/9294296703',
          listener: (MobileAdEvent event) {
            print("============================= Interstitial banner ad event: $event");
            if (event == MobileAdEvent.closed || event == MobileAdEvent.failedToLoad) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ResultScreen()),
              );
            }
          })
        ..load()
        ..show();
    });
  }

  @override
  Widget build(BuildContext context) {
    _startTimer(context);
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
