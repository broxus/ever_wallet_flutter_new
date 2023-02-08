import 'dart:developer' as developer;

import 'package:fancy_logger/fancy_logger.dart';
import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:logging/logging.dart';

/// Console logger
class ConsoleLogger extends AbstractLogger {
  @override
  void write(LogRecord record) {
    var trace = record.error?.toString();
    trace = trace != null ? '\n$trace\n' : '';
    final message = _colorMessage(
      // ignore: lines_longer_than_80_chars
      '${record.level.name}: ${record.time}: ${record.message}$trace',
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
  }

  String _colorMessage(String message, Level level) {
    final colorString = _colorMap[level]?.value ?? '';
    return '$colorString$message${ConsoleColor.reset.value}';
  }

  /// The color map
  final Map<Level, ConsoleColor> _colorMap = {
    Level.FINEST: ConsoleColor.green,
    Level.FINER: ConsoleColor.green,
    Level.FINE: ConsoleColor.green,
    Level.CONFIG: ConsoleColor.blue,
    Level.INFO: ConsoleColor.cyan,
    Level.WARNING: ConsoleColor.yellow,
    Level.SEVERE: ConsoleColor.red,
    Level.SHOUT: ConsoleColor.red,
  };
}
