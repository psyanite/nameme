import 'package:crystal/models/emoji.dart';

class Question {
  final String question;
  final List<Emoji> emojis;
  final bool isLast;
  final bool isMulti;

  Question({
    this.question,
    this.emojis,
    this.isLast = false,
    this.isMulti = false,
  });
}

enum EmojiType { Animal, Blood, Drink, Extra, Food, Gender, Scenery, Weather}