import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:fancy_logger/src/console_logger.dart';
import 'package:fancy_logger/src/db_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// {@template fancy_logger}
/// Fancy logger
/// {@endtemplate}
@singleton
class FancyLogger {
  /// {@macro fancy_logger}
  FancyLogger();

  final _log = Logger('FancyLogger');
  final _consoleLogger = ConsoleLogger();
  final _dbLogger = DbLogger();
  late final List<AbstractLogger> _loggers = [_consoleLogger, _dbLogger];

  /// Init app logger
  Future<void> init(Level level) async {
    Logger.root.level = level;
    for (final logger in _loggers) {
      await logger.init();
    }
    Logger.root.onRecord.listen(_writeRecord);

    await startSession();
  }

  void _writeRecord(LogRecord record) {
    for (final logger in _loggers) {
      logger.write(record);
    }
  }

  /// Increment session id
  Future<void> startSession() async {
    final logStrings = <String>[];
    for (final logger in _loggers) {
      final logString = await logger.sessionStart();
      if (logString != null) {
        logStrings.add(logString);
      }
    }

    final logStringsReduced = logStrings.reduce(
      (value, element) => value = '$value, $element',
    );
    _log.fine('Session start $logStringsReduced');
  }

  /// Get all logs as strings (for debug purposes only)
  Future<String> getAllLogs() async => _dbLogger.getAllLogs();
}
