import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:fancy_logger/src/console_logger.dart';
import 'package:fancy_logger/src/db_logger.dart';
import 'package:flutter/foundation.dart';
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
  late List<AbstractLogger> _loggers = [];
  Level _minLevel = Level.ALL;

  /// Init app logger
  /// [retainStrategy] processing algorythm:
  /// * sort all records by level (ALL->OFF)
  /// * record with minimum level will be used as global filter
  ///   (for storing and printing)
  /// * each integer for a level means how many sessions the records with this
  ///   level will be retained
  /// * each next entry will add this number
  /// * if [retainStrategy] is empty => {Level.ALL: 100}
  /// So, examples:
  ///
  /// {
  ///   Level.ALL:      200,  // ALL records with be deleted after 200 sessions
  ///   Level.INFO:     100,  // records with INFO and higher level retained for 300 sessions
  ///   Level.SEVERE:   50,   // records with SEVERE and higher level retained for 350 sessions
  /// }
  ///
  /// {
  ///   Level.CONFIG:   200,  // records with CONFIG and higher level retained for 200 sessions
  ///                         // lower level records (FINE, FINER and FINEST) will not
  ///                         // be printed nor stored because lowest level in the map
  ///                         // is CONFIG
  ///   Level.INFO:     100,  // records with INFO and higher level retained for 300 sessions
  ///   Level.SEVERE:   50,   // records with SEVERE and higher level retained for 350 sessions
  /// }
  ///
  /// {
  ///   Level.OFF:   0,       // disable logging
  /// }
  ///
  /// {
  ///   Level.ALL:   1,       // all level records will be retained for 1 session
  ///                         // (i.e. you will be able to retrieve the logs from the
  ///                         // previous run)
  /// }
  Future<void> init(
    Map<Level, int> retainStrategy, {
    bool startNewSession = true,
    bool consoleLogger = true,
    bool dbLogger = true,
    ConsoleLoggerCallback? consoleLoggerCallback,
  }) async {
    // If there are no explicit instructions on how to retain logs
    final retainStrategyNotEmpty =
        retainStrategy.isEmpty ? {Level.ALL: 100} : retainStrategy;

    _minLevel = retainStrategyNotEmpty.keys.reduce(
      (value, element) => element.compareTo(value) < 0 ? element : value,
    );

    Logger.root.level = _minLevel;
    _loggers = <AbstractLogger>[
      if (consoleLogger) ConsoleLogger(consoleLoggerCallback),
      if (dbLogger) DbLogger(),
    ];

    for (final logger in _loggers) {
      await logger.init(retainStrategy);
    }

    Logger.root.clearListeners();
    Logger.root.onRecord.listen(_writeRecord);

    if (startNewSession) await startSession();
  }

  /// Get computed minimal level
  Level get minLevel => _minLevel;

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

    final logStringsReduced = logStrings.fold(
      '',
      (value, element) => value = '$value$element',
    );
    _log.fine('Session start $logStringsReduced');
  }

  /// Get all logs as strings (for debug purposes only)
  // TODO(nesquikm): uncomment visibleForTesting after removing call
  // from LogDisplayCubit
  // @visibleForTesting
  Future<String> getAllLogsAsString() async => _dbLogger.getAllLogsAsString();

  /// Get all logs as [LogRecord]s (for debug purposes only)
  @visibleForTesting
  Future<List<LogRecord>> getAllLogs() async => _dbLogger.getAllLogs();

  /// Get all logs as maps (for debug purposes only)
  @visibleForTesting
  Future<List<Map<String, Object?>>> getAllLogsAsMaps() async =>
      _dbLogger.getAllLogsAsMaps();

  /// Write logs to archived JSON, return file path
  Future<String> writeAllLogsToJson([String filename = 'logs.json']) async =>
      _dbLogger.writeAllLogsToJson(filename);

  /// Clear logs (for debug purposes only)
  @visibleForTesting
  Future<void> clearAllLogs() => _dbLogger.clearAllLogs();

  DbLogger get _dbLogger {
    final dbLogger =
        _loggers.firstWhereOrNull((logger) => logger is DbLogger) as DbLogger?;
    if (dbLogger == null) {
      throw Exception('DbLogger is not initialized!');
    }

    return dbLogger;
  }
}
