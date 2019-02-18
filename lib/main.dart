import 'package:crystal/components/splash_screen.dart';
import 'package:crystal/config/config.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/presentation/platform_adaptive.dart';
import 'package:crystal/state/app/app_reducer.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() async {
  List<Middleware<AppState>> createMiddleware() {
    return <Middleware<AppState>>[
      thunkMiddleware,
      LoggingMiddleware.printer(),
    ];
  }

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: createMiddleware(),
  );

  runApp(_Main(store: store));
}

class MainRoutes {
  static const String root = '/';
}

class _Main extends StatefulWidget {
  final store;

  _Main({this.store});

  @override
  _MainState createState() => new _MainState();
}

class _MainState extends State<_Main> {
  double _dpi = 1.0;

  _MainState();

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: Config.adMobId);
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'NameMe',
        color: Color(0xFFFB8B9D),
        theme: getTheme(context, _dpi),
        routes: <String, WidgetBuilder>{
          MainRoutes.root: (context) => SplashScreen(setDpi: (dpi) => setState(() => setState(() => _dpi = dpi))),
        },
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ko', ''),
          const Locale('ja', ''),
        ],
        navigatorObservers: <NavigatorObserver>[widget.store.state.me.observer],
      ),
    );
  }
}
