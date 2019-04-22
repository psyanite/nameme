import 'package:crystal/state/me/me_state.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Util {
  static String getBio(MeState me, String name, String languageCode) {
    switch (languageCode) {
      case 'ko':
        return _koBio(me, name);
      case 'ja':
        return _jaBio(me, name);
      case 'en':
      default:
        return _enBio(me, name);
    }
  }

  static String _enBio(MeState me, String name) {
    final template = "My name is {name}. I'm {blood} blood-type who likes {animal} and {food}. " +
        "I enjoy drinking {drink} {scenery} {weather}. I like {extra-1}, {extra-2}, and {extra-3}.";
    return template
        .replaceAll('{name}', name)
        .replaceAll('{blood}', me.blood.en)
        .replaceAll('{animal}', me.animal.en)
        .replaceAll('{food}', me.food.en)
        .replaceAll('{drink}', me.drink.en)
        .replaceAll('{scenery}', me.scenery.en)
        .replaceAll('{weather}', me.weather.en)
        .replaceAll('{extra-1}', me.extras[0].en)
        .replaceAll('{extra-2}', me.extras[1].en)
        .replaceAll('{extra-3}', me.extras[2].en);
  }

  static String _koBio(MeState me, String name) {
    final template = "저의 이름은 {name} 입니다. 저는 {blood}형 이고, {animal}동물, {food}음식을 좋아합니다. " +
        "{weather}, 저는 {scenery}에서  술 마시는 {drink} 좋아해요. 나는{extra-1},{extra-2},{extra-3}.";
    return template
        .replaceAll('{name}', name)
        .replaceAll('{blood}', me.blood.ko)
        .replaceAll('{animal}', me.animal.ko)
        .replaceAll('{food}', me.food.ko)
        .replaceAll('{drink}', me.drink.ko)
        .replaceAll('{scenery}', me.scenery.ko)
        .replaceAll('{weather}', me.weather.ko)
        .replaceAll('{extra-1}', me.extras[0].ko)
        .replaceAll('{extra-2}', me.extras[1].ko)
        .replaceAll('{extra-3}', me.extras[2].ko);
  }

  static String _jaBio(MeState me, String name) {
    final template = "私の名前は{name}です. {blood}型血液型で{animal}と{food}が好きです. " +
        "{weather}で{scenery}で{drink}を飲むが好きです. それとも{extra-1},{extra-2}と{extra-3}が気に入っている.";
    return template
        .replaceAll('{name}', name)
        .replaceAll('{blood}', me.blood.ja)
        .replaceAll('{animal}', me.animal.ja)
        .replaceAll('{food}', me.food.ja)
        .replaceAll('{drink}', me.drink.ja)
        .replaceAll('{scenery}', me.scenery.ja)
        .replaceAll('{weather}', me.weather.ja)
        .replaceAll('{extra-1}', me.extras[0].ja)
        .replaceAll('{extra-2}', me.extras[1].ja)
        .replaceAll('{extra-3}', me.extras[2].ja);
  }

  static BannerAd buildBannerAd() {
    return BannerAd(
//        adUnitId: BannerAd.testAdUnitId,
        adUnitId: 'ca-app-pub-6524279756456110/5953941201',
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print("============================= Banner ad event: $event");
        });
  }
}
