import 'package:crystal/models/emoji.dart';
import 'package:crystal/state/me/me_actions.dart';
import 'package:crystal/state/me/me_state.dart';
import 'package:redux/redux.dart';

Reducer<MeState> meReducer = combineReducers([
  new TypedReducer<MeState, SetMediaData>(setMediaQuery),
  new TypedReducer<MeState, AddEmoji>(addEmoji),
  new TypedReducer<MeState, AddEmojis>(addEmojis),
  new TypedReducer<MeState, ClearMe>(clearMe),
]);

MeState addEmoji(MeState state, AddEmoji action) {
  switch (action.emoji.type) {
    case EmojiType.Animal:
      return state.copyWith(animal: action.emoji);
    case EmojiType.Blood:
      return state.copyWith(blood: action.emoji);
    case EmojiType.Drink:
      return state.copyWith(drink: action.emoji);
    case EmojiType.Food:
      return state.copyWith(food: action.emoji);
    case EmojiType.Gender:
      return state.copyWith(gender: action.emoji);
    case EmojiType.Scenery:
      return state.copyWith(scenery: action.emoji);
    case EmojiType.Weather:
      return state.copyWith(weather: action.emoji);
    default:
      return state;
  }
}

MeState setMediaQuery(MeState state, SetMediaData action) {
  return state.copyWith(mediaData: action.mediaQuery);
}

MeState addEmojis(MeState state, AddEmojis action) {
  return state.copyWith(extras: action.emojis);
}

MeState clearMe(MeState state, ClearMe action) {
  return MeState().copyWith(mediaData: state.mediaData);
}
