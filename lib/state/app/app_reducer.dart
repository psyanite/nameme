import 'package:crystal/state/app/app_state.dart';
import 'package:crystal/state/error/error_reducer.dart';
import 'package:crystal/state/me/me_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(me: meReducer(state.me, action), error: errorReducer(state.error, action));
}
