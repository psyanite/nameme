import 'package:crust/components/screens/home_screen.dart';
import 'package:crust/presentation/platform_adaptive.dart';
import 'package:crust/state/app/app_reducer.dart';
import 'package:crust/state/app/app_state.dart';
import 'package:flutter/material.dart';
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
      child: MaterialApp(title: 'NameMe', theme: getTheme(context), routes: <String, WidgetBuilder>{
        MainRoutes.root: (context) => HomeScreen(),
      }),
    );
  }
}
