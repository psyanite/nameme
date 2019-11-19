# 🔮 NameMe

🔮 Make your own Magic

🔥 Download and install the APK [now](https://github.com/psyanite/nameme/blob/master/docs/nameme.apk)!

NameMe is a Flutter-Dart internationalized app available in Korean, Japanese and English. Whether you're looking for a new name for yourself, your friend or your baby, NameMe is exactly what you need. Simply answer 8 questions and discover your unique name! Share your name via any social media of choice. 

## Features
* Integrated with Firebase Google Admob with Banner and Interstitial ads
* Uses a unique algorithm to select a random female or male name
* Provides over 50 female and 60 male names
* Based on the [nameme-mockups](https://github.com/psyanite/nameme-mockup) built in SCSS and HTML
* The CSV file of curated names is generated via the Scala [nameme-generator](https://github.com/psyanite/nameme-generator)

<div align="center">
  <img src="https://github.com/psyanite/nameme/blob/master/docs/images/splash.jpg" width="250px"/>
  <img src="https://github.com/psyanite/nameme/blob/master/docs/images/landing.jpg" width="250px"/>
</div>
<div align="center">
  <img src="https://github.com/psyanite/nameme/blob/master/docs/images/question.jpg" width="250px"/>
  <img src="https://github.com/psyanite/nameme/blob/master/docs/images/result-en.jpg" width="250px"/>
  <img src="https://github.com/psyanite/nameme/blob/master/docs/images/result-jp.jpg" width="250px"/>
</div>

## Things To Do
* Add [Google app ID](https://firebase.google.com/docs/android/setup)
* Implement name pronunciations
* Get 20-30 different Korean name meanings
* Get Korean translation for in-app phrases
* Get Japanese translations for in-app phrases

## Ideas
* Name variations 
* Allow users to save names as favorites for later access

## How to Locale
* Add new get functions in `locale/locales.dart`
* Run `flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale\locales.dart`
* Update values in `l10n/int_*.arb` files
* Run `flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_ko.arb lib/l10n/intl_en.arb lib/l10n/intl_messages.arb lib/l10n/intl_ja.arb lib/locale/locales.dart`

## How to Icons
* Update icons in `assets/launcher`
* Run `flutter packages pub run flutter_launcher_icons:main`

## How to APK
* Update version in `local.properties`
* Run `flutter clean && flutter build apk --target-platform android-arm,android-arm64 --split-per-abi --release`
