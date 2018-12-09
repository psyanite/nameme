import 'package:crystal/utils/enum_util.dart';
import 'package:flutter/widgets.dart';

class Emoji {
  final String name;
  final EmojiType type;

  static final List<Emoji> animals = [
    Emoji(name: 'bear', type: EmojiType.Animal),
    Emoji(name: 'cat', type: EmojiType.Animal),
    Emoji(name: 'cat', type: EmojiType.Animal),
    Emoji(name: 'dog', type: EmojiType.Animal),
    Emoji(name: 'koala', type: EmojiType.Animal),
    Emoji(name: 'pig', type: EmojiType.Animal),
    Emoji(name: 'rabbit', type: EmojiType.Animal),
  ];

  static final List<Emoji> bloods = [
    Emoji(name: 'A', type: EmojiType.Blood),
    Emoji(name: 'AB', type: EmojiType.Blood),
    Emoji(name: 'B', type: EmojiType.Blood),
    Emoji(name: 'O', type: EmojiType.Blood),
  ];

  static final List<Emoji> drinks = [
    Emoji(name: 'beer', type: EmojiType.Drink),
    Emoji(name: 'cocktail', type: EmojiType.Drink),
    Emoji(name: 'coffee', type: EmojiType.Drink),
    Emoji(name: 'mojito', type: EmojiType.Drink),
    Emoji(name: 'sake', type: EmojiType.Drink),
    Emoji(name: 'tea', type: EmojiType.Drink),
  ];

  static final List<Emoji> extras = [
    Emoji(name: 'camera', type: EmojiType.Extra),
    Emoji(name: 'lipstick', type: EmojiType.Extra),
    Emoji(name: 'movie', type: EmojiType.Extra),
    Emoji(name: 'nails', type: EmojiType.Extra),
    Emoji(name: 'paintbrush', type: EmojiType.Extra),
    Emoji(name: 'plane', type: EmojiType.Extra),
    Emoji(name: 'shopping', type: EmojiType.Extra),
    Emoji(name: 'sparkles', type: EmojiType.Extra),
    Emoji(name: 'shopping', type: EmojiType.Extra),
    Emoji(name: 'sparkles', type: EmojiType.Extra),
    Emoji(name: 'tulip', type: EmojiType.Extra),
  ];

  static final List<Emoji> food = [
    Emoji(name: 'burgers', type: EmojiType.Food),
    Emoji(name: 'chocolate', type: EmojiType.Food),
    Emoji(name: 'dumplings', type: EmojiType.Food),
    Emoji(name: 'pretzel', type: EmojiType.Food),
    Emoji(name: 'salad', type: EmojiType.Food),
    Emoji(name: 'soup', type: EmojiType.Food),
  ];

  static final List<Emoji> genders = [
    Emoji(name: 'female', type: EmojiType.Gender),
    Emoji(name: 'male', type: EmojiType.Gender),
  ];

  static final List<Emoji> sceneries = [
    Emoji(name: 'beach', type: EmojiType.Scenery),
    Emoji(name: 'city', type: EmojiType.Scenery),
    Emoji(name: 'mountains', type: EmojiType.Scenery),
    Emoji(name: 'park', type: EmojiType.Scenery),
  ];

  static final List<Emoji> weather = [
    Emoji(name: 'cloudy', type: EmojiType.Weather),
    Emoji(name: 'rain', type: EmojiType.Weather),
    Emoji(name: 'rainbows', type: EmojiType.Weather),
    Emoji(name: 'snow', type: EmojiType.Weather),
    Emoji(name: 'stormy', type: EmojiType.Weather),
    Emoji(name: 'sunny', type: EmojiType.Weather),
  ];


  Widget getImage() {
    String path = 'assets/emojis/${EnumUtil.format(this.type.toString()).toLowerCase()}/${this.name}.png';
    return Image.asset(path);
  }

  Emoji({
    this.name,
    this.type,
  });
}

enum EmojiType { Animal, Blood, Drink, Extra, Food, Gender, Scenery, Weather}