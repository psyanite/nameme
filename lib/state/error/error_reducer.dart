import 'package:crystal/state/error/error_actions.dart';
import 'package:crystal/state/error/error_state.dart';
import 'package:redux/redux.dart';

Reducer<ErrorState> errorReducer = combineReducers([
  new TypedReducer<ErrorState, RequestFailure>(requestFailure),
]);

ErrorState requestFailure(ErrorState state, RequestFailure action) {
  return state.copyWith(message: action.error.toString().replaceAll("\n", " "));
}
