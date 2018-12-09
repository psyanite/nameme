import 'package:crystal/components/home_screen.dart';
import 'package:crystal/components/loading_screen.dart';
import 'package:crystal/locale/locales.dart';
import 'package:crystal/presentation/platform_adaptive.dart';
import 'package:crystal/state/app/app_reducer.dart';
import 'package:crystal/state/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

  runApp(Main(store: store));
}

class MainRoutes {
  static const String root = '/';
}

class Main extends StatelessWidget {
  final store;

  Main({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: getTheme(context),
        routes: <String, WidgetBuilder>{
          MainRoutes.root: (context) => LoadingScreen(),
        },
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('kr', ''),
          const Locale('ja', ''),
        ],
      ),
    );
  }
}
