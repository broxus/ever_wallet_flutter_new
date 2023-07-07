import 'dart:async';
import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

enum SupportedLocaleCodes {
  en,
  ko;

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
      (locale) => Locale(locale.name),
    )
    .toList();
final fallbackLocale = Locale(fallbackLocaleCode.name);

/// Service that shows messages to the user. Keep is simple and stupid, use only
/// as stream sources for blocs and cubits that actual provide messages to the
/// user.
@singleton
class LocalizationService {
  final _log = Logger('LocalizationService');

  final StreamController<void> _refreshLocaleStreamController =
      StreamController<void>.broadcast();

  Stream<void> get refreshLocaleStream => _refreshLocaleStreamController.stream;

  void refreshLocale() {
    _log.finest('refreshing locales');
    _refreshLocaleStreamController.add(null);
  }

  final _localeCodeStreamController = BehaviorSubject<SupportedLocaleCodes>();

  void setLocaleByLanguageCode(SupportedLocaleCodes code) {
    if (_localeCodeStreamController.valueOrNull == code) return;
    _log.finest('setting locale by code ${code.name}');

    _localeCodeStreamController.add(code);
  }

  SupportedLocaleCodes get localeCode =>
      _localeCodeStreamController.valueOrNull ?? fallbackLocaleCode;

  ValueStream<SupportedLocaleCodes> get localeCodeStream =>
      _localeCodeStreamController.stream;
}
