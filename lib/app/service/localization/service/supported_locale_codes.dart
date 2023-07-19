import 'dart:ui';

import 'package:app/generated/generated.dart';

enum SupportedLocaleCodes {
  en(LocaleKeys.langEnglish),
  ko(LocaleKeys.langKorean);

  const SupportedLocaleCodes(this.localizedString);

  final String localizedString;

  String get iconPath => switch (this) {
        SupportedLocaleCodes.en => Assets.images.langIcons.english.path,
        SupportedLocaleCodes.ko => Assets.images.langIcons.korean.path,
      };

  Locale get locale => Locale(name);

  static SupportedLocaleCodes byName(String name) {
    for (final value in SupportedLocaleCodes.values) {
      if (value.name == name) return value;
    }

    return fallbackLocaleCode;
  }
}

const fallbackLocaleCode = SupportedLocaleCodes.en;

final supportedLocales = SupportedLocaleCodes.values
    .map(
      (locale) => locale.locale,
    )
    .toList();
final fallbackLocale = Locale(fallbackLocaleCode.name);
