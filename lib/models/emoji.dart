import 'package:crystal/utils/enum_util.dart';
import 'package:flutter/widgets.dart';

class Emoji {
  final String name;
  final EmojiType type;
  final String en;
  final String ko;
  final String ja;

  Emoji({
    this.name,
    this.type,
    this.en,
    this.ko,
    this.ja,
  });

  static final List<Emoji> animals = [
    Emoji(name: 'bear', type: EmojiType.Animal, en: 'bears', ko: '곰', ja: 'くま'),
    Emoji(name: 'cat', type: EmojiType.Animal, en: 'cats', ko: '고양이', ja: 'ねこ'),
    Emoji(name: 'dog', type: EmojiType.Animal, en: 'dogs', ko: '강아지', ja: 'いぬ'),
    Emoji(name: 'koala', type: EmojiType.Animal, en: 'koalas', ko: '코알라', ja: 'コアラ'),
    Emoji(name: 'hamster', type: EmojiType.Animal, en: 'hamsters', ko: '햄스터', ja: 'ハムスター'),
    Emoji(name: 'rabbit', type: EmojiType.Animal, en: 'rabbits', ko: '토끼', ja: 'うさぎ'),
  ];

  static final List<Emoji> bloods = [
    Emoji(name: 'a', type: EmojiType.Blood, en: 'A', ko: 'A', ja: 'A'),
    Emoji(name: 'ab', type: EmojiType.Blood, en: 'AB', ko: 'AB', ja: 'AB'),
    Emoji(name: 'b', type: EmojiType.Blood, en: 'B', ko: 'B', ja: 'B'),
    Emoji(name: 'o', type: EmojiType.Blood, en: 'O', ko: 'O', ja: 'O'),
  ];

  static final List<Emoji> drinks = [
    Emoji(name: 'beer', type: EmojiType.Drink, en: 'beer', ko: '맥주', ja: 'ビール'),
    Emoji(name: 'cocktail', type: EmojiType.Drink, en: 'cocktail', ko: '칵테일', ja: 'カクテル'),
    Emoji(name: 'coffee', type: EmojiType.Drink, en: 'coffee', ko: '커피', ja: 'コーヒー'),
    Emoji(name: 'mojito', type: EmojiType.Drink, en: 'mojito', ko: '모히또', ja: 'モヒート'),
    Emoji(name: 'sake', type: EmojiType.Drink, en: 'sake', ko: '사케', ja: 'さけ'),
    Emoji(name: 'tea', type: EmojiType.Drink, en: 'tea', ko: '차', ja: 'お茶'),
  ];

  static final List<Emoji> extras = [
    Emoji(name: 'movies', type: EmojiType.Extra, en: 'movies', ko: '영화', ja: '映画'),
    Emoji(name: 'music', type: EmojiType.Extra, en: 'music', ko: '음악', ja: '音楽'),
    Emoji(name: 'nature', type: EmojiType.Extra, en: 'nature', ko: '자연', ja: '描画'),
    Emoji(name: 'painting', type: EmojiType.Extra, en: 'painting', ko: '미술', ja: 'くま'),
    Emoji(name: 'photography', type: EmojiType.Extra, en: 'photography', ko: '사진', ja: 'フォトグラフィー'),
    Emoji(name: 'shopping', type: EmojiType.Extra, en: 'shopping', ko: '쇼핑', ja: '買い物'),
    Emoji(name: 'skating', type: EmojiType.Extra, en: 'skating', ko: '스케이트', ja: 'アイススケート'),
    Emoji(name: 'travelling', type: EmojiType.Extra, en: 'travelling', ko: '여행', ja: '旅行'),
  ];

  static final List<Emoji> food = [
    Emoji(name: 'burgers', type: EmojiType.Food, en: 'burgers', ko: '햄버거', ja: 'ハムバーガー'),
    Emoji(name: 'chocolate', type: EmojiType.Food, en: 'chocolate', ko: '초콜릿', ja: 'チョコレート'),
    Emoji(name: 'dumplings', type: EmojiType.Food, en: 'dumplings', ko: '만두', ja: '餃子'),
    Emoji(name: 'pretzels', type: EmojiType.Food, en: 'pretzels', ko: '프렛즐', ja: 'プレッツェル'),
    Emoji(name: 'salad', type: EmojiType.Food, en: 'salad', ko: '샐러드', ja: 'サラダ'),
    Emoji(name: 'soup', type: EmojiType.Food, en: 'soup', ko: '스프', ja: 'スープ'),
  ];

  static final List<Emoji> genders = [
    Emoji(name: 'female', type: EmojiType.Gender),
    Emoji(name: 'male', type: EmojiType.Gender),
  ];

  static final List<Emoji> sceneries = [
    Emoji(name: 'beach', type: EmojiType.Scenery, en: 'at the beach', ko: '바닷가', ja: '海'),
    Emoji(name: 'city', type: EmojiType.Scenery, en: 'in the city', ko: '도시', ja: '街'),
    Emoji(name: 'mountains', type: EmojiType.Scenery, en: 'in the mountains', ko: '도시', ja: '山'),
    Emoji(name: 'park', type: EmojiType.Scenery, en: 'at the park', ko: '공원', ja: 'パーク'),
  ];

  static final List<Emoji> weather = [
    Emoji(name: 'cloudy', type: EmojiType.Weather, en: 'in cloudy weather', ko: '흐린날', ja: '曇りの日'),
    Emoji(name: 'rain', type: EmojiType.Weather, en: 'in the rain', ko: '비오는날', ja: '雨の日'),
    Emoji(name: 'rainbows', type: EmojiType.Weather, en: 'under a rainbow', ko: '무지개', ja: '虹がある時'),
    Emoji(name: 'snow', type: EmojiType.Weather, en: 'when it\'s snowing', ko: '눈 오는날', ja: '雪が降っている時'),
    Emoji(name: 'stormy', type: EmojiType.Weather, en: 'during a storm', ko: '번개', ja: '嵐の時'),
    Emoji(name: 'sunny', type: EmojiType.Weather, en: 'under the sun', ko: '햇볕', ja: '晴れた日'),
  ];

  Widget getImage({double scale}) {
    String path = 'assets/emojis/${EnumUtil.format(this.type.toString()).toLowerCase()}/${this.name}.png';
    return Image.asset(path, scale: scale ?? 3.0);
  }
}

enum EmojiType { Animal, Blood, Drink, Extra, Food, Gender, Scenery, Weather }
