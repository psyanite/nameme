import 'package:crust/state/app/app_state.dart';
import 'package:crust/state/error/error_reducer.dart';
import 'package:crust/state/me/me_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      me: meReducer(state.me, action),
      error: errorReducer(state.error, action));
}
