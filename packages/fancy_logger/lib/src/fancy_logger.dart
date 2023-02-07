import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// {@template fancy_logger}
/// Fancy logger
/// {@endtemplate}
@singleton
class FancyLogger {
  /// {@macro fancy_logger}
  const FancyLogger();

  /// Init app logger
  Future<void> start() async {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      debugPrint(
        // ignore: lines_longer_than_80_chars
        '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}',
      );
    });
  }
}
