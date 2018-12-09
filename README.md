# crystal

Make your own Magic

## How to Locale
* Add new get functions in `locale/locales.dart`
* Run `flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale\locales.dart`
* Run `flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_kr.arb lib/l10n/intl_en.arb lib/l10n/intl_messages.arb lib/l10n/intl_ja.arb lib/locale/locales.dart`
* Update values in `l10n/int_*.arb` files

## Things To Do
* Get ~20 different Korean name descriptions
* Get ~20 different English name descriptions
* Write Scala class that converts Excel and fills in the blanks of random descriptions

## Must Haves 
* Name pronunciations

## Ideas
* Name variations 
