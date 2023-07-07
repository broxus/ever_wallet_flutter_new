import 'dart:async';
import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const supportedLocaleCodes = ['en', 'ko'];
const fallbackLocaleCode = 'en';

final supportedLocales = supportedLocaleCodes.map(Locale.new).toList();
const fallbackLocale = Locale(fallbackLocaleCode);

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

  final _localeStreamController = BehaviorSubject<String>();

  void setLocaleByLanguageCode(String code) {
    _log.finest('setting locale by code $code');
    _localeStreamController.add(code);
  }

  String get locale =>
      _localeStreamController.valueOrNull ?? fallbackLocaleCode;

  ValueStream<String> get localeStream => _localeStreamController.stream;
}
