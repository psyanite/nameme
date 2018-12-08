import 'package:crust/state/me/me_actions.dart';
import 'package:crust/state/me/me_state.dart';
import 'package:redux/redux.dart';

Reducer<MeState> meReducer = combineReducers([
  new TypedReducer<MeState, FavoriteRewardSuccess>(favoriteReward),
]);

MeState favoriteReward(MeState state, FavoriteRewardSuccess action) {
  return state.copyWith(favoriteRewards: action.rewards);
}
