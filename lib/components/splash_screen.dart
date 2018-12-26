import 'dart:async';
import 'dart:io';

import 'package:crystal/components/home_screen.dart';
import 'package:crystal/presentation/theme.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/me/me_actions.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
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
    return Timer(Duration(seconds: 3), () {
      widget.setDpi(MediaQuery.of(context).textScaleFactor);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Props>(
        converter: (Store<AppState> store) => _Props.fromStore(store),
        builder: (context, props) => _presenter(context, props.analytics, props.setMediaQuery),
        rebuildOnChange: false);
  }

  _presenter(BuildContext context, FirebaseAnalytics analytics, Function setMediaQuery) {
    _setAnalyticsUserId(analytics);
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

  Future<void> _setAnalyticsUserId(FirebaseAnalytics analytics) async {
    String id;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        id = 'android-${build.model}-${build.device}-${build.version.toString()}-${build.androidId}';
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        id = 'ios-${data.name}-${data.systemVersion}-${data.identifierForVendor}';
      }
    } on PlatformException {
      id = 'error-${DateTime.now().toUtc()}';
    }
    analytics.setUserId(id);
  }
}

class _Props {
  final Function setMediaQuery;
  final FirebaseAnalytics analytics;

  _Props({this.setMediaQuery, this.analytics});

  static fromStore(Store<AppState> store) {
    return _Props(
      setMediaQuery: (mediaQuery) => store.dispatch(SetMediaData(mediaQuery)),
      analytics: store.state.me.analytics,
    );
  }
}
