import 'package:crystal/utils/enum_util.dart';
import 'package:flutter/widgets.dart';

class Emoji {
  final String name;
  final EmojiType type;

  static final List<Emoji> animals = [
    Emoji(name: 'bear', type: EmojiType.Animal),
    Emoji(name: 'cat', type: EmojiType.Animal),
    Emoji(name: 'dog', type: EmojiType.Animal),
    Emoji(name: 'koala', type: EmojiType.Animal),
    Emoji(name: 'pig', type: EmojiType.Animal),
    Emoji(name: 'rabbit', type: EmojiType.Animal),
  ];

  static final List<Emoji> bloods = [
    Emoji(name: 'a', type: EmojiType.Blood),
    Emoji(name: 'ab', type: EmojiType.Blood),
    Emoji(name: 'b', type: EmojiType.Blood),
    Emoji(name: 'o', type: EmojiType.Blood),
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
    Emoji(name: 'movies', type: EmojiType.Extra),
    Emoji(name: 'music', type: EmojiType.Extra),
    Emoji(name: 'nature', type: EmojiType.Extra),
    Emoji(name: 'painting', type: EmojiType.Extra),
    Emoji(name: 'photography', type: EmojiType.Extra),
    Emoji(name: 'shopping', type: EmojiType.Extra),
    Emoji(name: 'skating', type: EmojiType.Extra),
    Emoji(name: 'travelling', type: EmojiType.Extra),
  ];

  static final List<Emoji> food = [
    Emoji(name: 'burgers', type: EmojiType.Food),
    Emoji(name: 'chocolate', type: EmojiType.Food),
    Emoji(name: 'dumplings', type: EmojiType.Food),
    Emoji(name: 'pretzels', type: EmojiType.Food),
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


  Widget getImage({double scale}) {
    String path = 'assets/emojis/${EnumUtil.format(this.type.toString()).toLowerCase()}/${this.name}.png';
    return Image.asset(path, scale: scale ?? 3.0);
  }

  Emoji({
    this.name,
    this.type,
  });
}

enum EmojiType { Animal, Blood, Drink, Extra, Food, Gender, Scenery, Weather}