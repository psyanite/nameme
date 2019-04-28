import 'dart:io';

import 'package:crystal/state/me/me_state.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter/services.dart' show PlatformException;

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

  static Future<PostgreSQLConnection> getToaster() async {
    var connection = PostgreSQLConnection(
      "ec2-174-129-10-235.compute-1.amazonaws.com", 5432, "d7m44nps91g6kq",
      username: "gmzifdigfxmosh",
      password: "ff0b1873dbf05d7898e02c6fc9f3b8be8f6150f26f8a06bd01f0da5b0e7c08a7",
      useSSL: true,
    );
    await connection.open();
    return connection;
  }

  static Future<String> getOs() async {
    try {
      if (Platform.isAndroid) {
        return 'android';
      } else if (Platform.isIOS) {
        return 'ios';
      }
      return 'unknown';
    } on PlatformException {
      return 'platform-exception';
    }
  }

  static Future<List<String>> getDeviceInfo() async {
    final DeviceInfoPlugin plugin = DeviceInfoPlugin();
    String id = 'error';
    String brand = '';
    String model = '';
    try {
      if (Platform.isAndroid) {
        var device = await plugin.androidInfo;
        id = 'android-${device.androidId}-${device.brand}-${device.manufacturer}-${device.model}-${device.board}-${device.bootloader}-${device.id}';
        brand = '${device.brand}-${device.manufacturer}';
        model = '${device.model}';
      } else if (Platform.isIOS) {
        var device = await plugin.iosInfo;
        id = 'ios-${device.name}-${device.systemName}-${device.systemVersion}-${device.identifierForVendor}';
        brand = 'apple';
        model = '${device.model}';
      } else {
        id = 'unknown-platform';
      }
    } on PlatformException {
      if (Platform.isAndroid) {
        id = 'android-platform-exception';
      } else if (Platform.isIOS) {
        id = 'ios-platform-exception';
      } else {
        id = 'unknown-platform-platform-exception';
      }
    }
    return [ id, brand, model ];
  }
}
