import 'dart:developer' as developer;

import 'package:fancy_logger/fancy_logger.dart';
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
  Future<void> init(Level level) async {
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      final message = _colorMessage(
        // ignore: lines_longer_than_80_chars
        '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}',
        record.level,
      );
      developer.log(
        message,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        level: record.level.value,
        name: record.loggerName,
        zone: record.zone,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });
  }

  /// The color map
  static final Map<Level, ConsoleColor> _colorMap = {
    Level.FINEST: ConsoleColor.white,
    Level.FINER: ConsoleColor.white,
    Level.FINE: ConsoleColor.green,
    Level.CONFIG: ConsoleColor.blue,
    Level.INFO: ConsoleColor.cyan,
    Level.WARNING: ConsoleColor.yellow,
    Level.SEVERE: ConsoleColor.red,
    Level.SHOUT: ConsoleColor.red,
  };

  String _colorMessage(String message, Level level) {
    final colorString = _colorMap[level]?.value ?? '';
    return '$colorString$message${ConsoleColor.reset.value}';
  }
}
