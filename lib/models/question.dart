import 'package:crystal/models/emoji.dart';

class Question {
  final String question;
  final List<Emoji> emojis;
  final bool isFirst;
  final bool isMulti;

  Question({
    this.question,
    this.emojis,
    this.isFirst = false,
    this.isMulti = false,
  });
}
