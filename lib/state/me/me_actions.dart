import 'package:crystal/models/emoji.dart';
import 'package:flutter/widgets.dart';

class SetMediaData {
  final MediaQueryData mediaQuery;

  SetMediaData(this.mediaQuery);
}

class AddEmoji {
  final Emoji emoji;

  AddEmoji(this.emoji);
}

class AddEmojis {
  final List<Emoji> emojis;

  AddEmojis(this.emojis);
}

class ClearMe {}
