import 'package:app/core/app_build_type.dart';
import 'package:app/utils/define_env.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryWorker {
  /// > Singleton
  factory SentryWorker() {
    return instance;
  }

  SentryWorker._();

  static final SentryWorker instance = SentryWorker._();

  /// < Singleton

  final _logger = Logger('Sentry');

  AppBuildType? _appBuildType;

  /// If dev build type - don't use sentry
  bool get _isUseSentry => _appBuildType != AppBuildType.development;

  Future<void> init(AppBuildType appBuildType) async {
    _appBuildType = appBuildType;

    if (!_isUseSentry) {
      _logger.info(
        'Sentry is not used in the ${_appBuildType?.name} build type',
      );
      return;
    }

    return SentryFlutter.init(
      (options) {
        options
          ..dsn = dsnDefineEnv
          ..tracesSampleRate = 1;
      },
    );
  }

  void captureException(
    dynamic exception, {
    dynamic stackTrace,
  }) {
    if (!_isUseSentry) {
      return;
    }
    Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
