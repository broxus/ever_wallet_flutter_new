import 'package:app/generated/generated.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/widgets.dart';

import 'package:logging/logging.dart';

/// This is a method that allows configure some feature-related services
Future<void> configureLocalization() async {
  final bootstrapLog = Logger('bootstrap')
    ..finest('EasyLocalization initializating...');
  final easyLocalizationLog = Logger('easyLocalization');

  WidgetsFlutterBinding.ensureInitialized();
  // easy_localization claims that this is needed
  void customLogPrinter(
    Object object, {
    LevelMessages? level,
    String? name,
    StackTrace? stackTrace,
  }) {
    final logLevel = switch (level) {
      LevelMessages.error => Level.SEVERE,
      LevelMessages.warning => Level.WARNING,
      LevelMessages.info => Level.INFO,
      LevelMessages.debug => Level.FINE,
      null => Level.FINE,
    };
    easyLocalizationLog.log(logLevel, object, null, stackTrace);
  }

  EasyLocalization.logger.printer = customLogPrinter;
  await EasyLocalization.ensureInitialized();

  bootstrapLog.finest('EasyLocalization initialized');
}
