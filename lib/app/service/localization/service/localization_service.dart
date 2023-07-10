import 'dart:async';

import 'package:app/app/service/localization/localization.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

/// Service that provides localization functionality for the app. Keep it
/// simple and stupid, use only as stream sources for blocs and cubits that
/// actually do the job
@singleton
class LocalizationService {
  final _log = Logger('LocalizationService');

  final StreamController<void> _refreshLocaleStreamController =
      StreamController<void>.broadcast();

  final StreamController<SupportedLocaleCodes> _updateLocaleStreamController =
      StreamController<SupportedLocaleCodes>.broadcast();

  /// This is an 'initiator' stream that allows to refresh locales from the
  /// [LocalizationServiceWidget], only for internal use with
  /// [LocalizationServiceWidget]
  Stream<void> get refreshLocaleStream => _refreshLocaleStreamController.stream;

  /// This is an 'initiator' stream that allows to update locales using the
  /// [LocalizationServiceWidget], only for internal use with
  /// [LocalizationServiceWidget]
  Stream<SupportedLocaleCodes> get updateLocaleStream =>
      _updateLocaleStreamController.stream;

  /// Do refresh locale (for example when system locale changes)
  void refreshLocale() {
    _log.finest('refreshing locales');
    _refreshLocaleStreamController.add(null);
  }

  /// Current locale code behavior subject
  final _localeCodeStreamController = BehaviorSubject<SupportedLocaleCodes>();

  /// This is just a 'callback' from [LocalizationServiceWidget] that allows
  /// to update locale code from the widget, only for internal use with
  /// [LocalizationServiceWidget]
  void updateCurrentLocaleByLanguageCodeFromServiceWidget(
    SupportedLocaleCodes code,
  ) {
    if (_localeCodeStreamController.valueOrNull == code) return;

    _log.finest('setting locale by code "${code.name}"');

    _localeCodeStreamController.add(code);
  }

  /// Public setter for locale code
  void changeLocaleCode(SupportedLocaleCodes code) {
    if (_localeCodeStreamController.valueOrNull == code) return;

    _log.finest('changing locale code to "${code.name}"');

    _updateLocaleStreamController.add(code);
  }

  /// Public getter for locale code
  SupportedLocaleCodes get localeCode =>
      _localeCodeStreamController.valueOrNull ?? fallbackLocaleCode;

  /// Public stream of locale code
  ValueStream<SupportedLocaleCodes> get localeCodeStream =>
      _localeCodeStreamController.stream;
}
