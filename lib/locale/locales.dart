import 'package:crystal/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    if (name == 'en') name = 'ko'; // Force Korean
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get landingPrompt1 {
    return Intl.message(
      'Let me help you find an English name',
      name: 'landingPrompt1',
    );
  }

  String get landingPrompt2 {
    return Intl.message(
      'Simply answer 8 questions',
      name: 'landingPrompt2',
    );
  }

  String get landingPrompt3 {
    return Intl.message(
      'And we\'ll find the perfect name for you',
      name: 'landingPrompt3',
    );
  }

  String get startButton {
    return Intl.message(
      'Let\'s Go!',
      name: 'startButton',
    );
  }

  String get genderQuestion {
    return Intl.message(
      'What\'s your gender?',
      name: 'genderQuestion',
    );
  }

  String get bloodQuestion {
    return Intl.message(
      'What\'s your blood-type?',
      name: 'bloodQuestion',
    );
  }

  String get foodQuestion {
    return Intl.message(
      'Pick your favorite',
      name: 'foodQuestion',
    );
  }

  String get animalQuestion {
    return Intl.message(
      'Pick your favorite',
      name: 'animalQuestion',
    );
  }

  String get weatherQuestion {
    return Intl.message(
      'Pick your favorite',
      name: 'weatherQuestion',
    );
  }

  String get drinkQuestion {
    return Intl.message(
      'Pick your favorite',
      name: 'drinkQuestion',
    );
  }

  String get sceneryQuestion {
    return Intl.message(
      'Pick your favorite',
      name: 'sceneryQuestion',
    );
  }

  String get extrasQuestion {
    return Intl.message(
      'Pick 3 favorites',
      name: 'extrasQuestion',
    );
  }

  String get selectOneError {
    return Intl.message(
      'Please pick 1',
      name: 'selectOneError',
    );
  }

  String get selectThreeError {
    return Intl.message(
      'Please pick 3',
      name: 'selectThreeError',
    );
  }

  String get nameDesc {
    return Intl.message(
      'Your name is',
      name: 'nameDesc',
    );
  }

  String get bioDesc {
    return Intl.message(
      'Your short bio',
      name: 'bioDesc',
    );
  }

  String get shareButton {
    return Intl.message(
      'Share',
      name: 'shareButton',
    );
  }

  String get shareMessage {
    return Intl.message(
      'My English name is {name}. Download the NameMe app and find out yours now!',
      name: 'shareMessage',
    );
  }

  String get goAgainButton {
    return Intl.message(
      'Go Again',
      name: 'goAgainButton',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja', 'ko'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
