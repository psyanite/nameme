import 'package:crystal/models/emoji.dart';
import 'package:meta/meta.dart';

@immutable
class MeState {
  final Emoji animal;
  final Emoji blood;
  final Emoji drink;
  final List<Emoji> extras;
  final Emoji foods;
  final Emoji gender;
  final Emoji scenery;
  final Emoji weather;

  MeState({
    this.animal,
    this.blood,
    this.drink,
    this.extras,
    this.foods,
    this.gender,
    this.scenery,
    this.weather,
  });

  MeState copyWith(
      {Emoji animal, Emoji blood, Emoji drink, List<Emoji> extras, Emoji foods, Emoji gender, Emoji scenery, Emoji weather}) {
    return MeState(
      animal: animal ?? this.animal,
      blood: blood ?? this.blood,
      drink: drink ?? this.drink,
      extras: extras ?? this.extras,
      foods: foods ?? this.foods,
      gender: gender ?? this.gender,
      scenery: scenery ?? this.scenery,
      weather: weather ?? this.weather,
    );
  }

  @override
  String toString() {
    return '''{
        animal: $animal,
        blood: $blood,
        drink: $drink,
        extras: $extras,
        foods: $foods,
        gender: $gender,
        scenery: $scenery,
        weather: $weather,
      }''';
  }
}
