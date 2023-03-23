// ignore_for_file: prefer_const_constructors

import 'package:fancy_logger/fancy_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory, do not use isolate here
  databaseFactory = databaseFactoryFfiNoIsolate;

  final log = Logger('TestLogger');

  group('FancyLogger can be instantiated', () {
    test('can be instantiated', () {
      expect(FancyLogger(), isNotNull);
    });
  });

  group('FancyLogger db tests', () {
    test('init and check empty', () async {
      final fancyLogger = FancyLogger();
      await fancyLogger.init({}, startNewSession: false);
      await fancyLogger.clearAllLogs();
      expect(await fancyLogger.getAllLogsAsString(), isEmpty);
    });

    test('add session and all log levels', () async {
      final fancyLogger = FancyLogger();
      await fancyLogger.init({Level.ALL: 100}, startNewSession: false);
      await fancyLogger.clearAllLogs();

      await fancyLogger.startSession();

      log
        ..finest('some finest log')
        ..finer('some finer log')
        ..fine('some fine log')
        ..config('some config log')
        ..info('some info log')
        ..warning('some warning log')
        ..severe('some severe log')
        ..shout('some shout log');

      final logs = await fancyLogger.getAllLogsAsMaps();

      expect(logs, hasLength(9));

      final sessionId = logs[0]['session_id'];
      expect(logs[0]['level'], Level.FINE.value);
      expect(logs[0]['message'], 'Session start new session id: $sessionId');
      expect(logs[0]['logger_name'], 'FancyLogger');

      expect(logs[1]['id'], (logs[0]['id']! as int) + 1);
      expect(logs[1]['session_id'], sessionId);
      expect(logs[1]['level'], Level.FINEST.value);
      expect(logs[1]['message'], 'some finest log');
      expect(logs[1]['logger_name'], 'TestLogger');

      expect(logs[2]['id'], (logs[1]['id']! as int) + 1);
      expect(logs[2]['session_id'], sessionId);
      expect(logs[2]['level'], Level.FINER.value);
      expect(logs[2]['message'], 'some finer log');
      expect(logs[2]['logger_name'], 'TestLogger');

      expect(logs[3]['id'], (logs[2]['id']! as int) + 1);
      expect(logs[3]['session_id'], sessionId);
      expect(logs[3]['level'], Level.FINE.value);
      expect(logs[3]['message'], 'some fine log');
      expect(logs[3]['logger_name'], 'TestLogger');

      expect(logs[4]['id'], (logs[3]['id']! as int) + 1);
      expect(logs[4]['session_id'], sessionId);
      expect(logs[4]['level'], Level.CONFIG.value);
      expect(logs[4]['message'], 'some config log');
      expect(logs[4]['logger_name'], 'TestLogger');

      expect(logs[5]['id'], (logs[4]['id']! as int) + 1);
      expect(logs[5]['session_id'], sessionId);
      expect(logs[5]['level'], Level.INFO.value);
      expect(logs[5]['message'], 'some info log');
      expect(logs[5]['logger_name'], 'TestLogger');

      expect(logs[6]['id'], (logs[5]['id']! as int) + 1);
      expect(logs[6]['session_id'], sessionId);
      expect(logs[6]['level'], Level.WARNING.value);
      expect(logs[6]['message'], 'some warning log');
      expect(logs[6]['logger_name'], 'TestLogger');

      expect(logs[7]['id'], (logs[6]['id']! as int) + 1);
      expect(logs[7]['session_id'], sessionId);
      expect(logs[7]['level'], Level.SEVERE.value);
      expect(logs[7]['message'], 'some severe log');
      expect(logs[7]['logger_name'], 'TestLogger');

      expect(logs[8]['id'], (logs[7]['id']! as int) + 1);
      expect(logs[8]['session_id'], sessionId);
      expect(logs[8]['level'], Level.SHOUT.value);
      expect(logs[8]['message'], 'some shout log');
      expect(logs[8]['logger_name'], 'TestLogger');
    });

    test('test retain strategy', () async {
      final fancyLogger = FancyLogger();
      await fancyLogger.init(
        {
          Level.FINEST: 1,
          Level.FINER: 1,
          Level.FINE: 1,
          Level.CONFIG: 1,
          Level.INFO: 1,
          Level.WARNING: 1,
          Level.SEVERE: 1,
          Level.SHOUT: 1,
        },
        startNewSession: false,
      );
      await fancyLogger.clearAllLogs();

      await fancyLogger.startSession();

      log
        ..finest('some finest log')
        ..finer('some finer log')
        ..fine('some fine log')
        ..config('some config log')
        ..info('some info log')
        ..warning('some warning log')
        ..severe('some severe log')
        ..shout('some shout log');

      var logs = (await fancyLogger.getAllLogsAsMaps()).where(
        (element) => !(element['message']! as String).contains('Session start'),
      );
      expect(
        logs,
        hasLength(8),
      );

      await Future.delayed(const Duration(milliseconds: 500), () {});
      logs = (await fancyLogger.getAllLogsAsMaps()).where(
        (element) => !(element['message']! as String).contains('Session start'),
      );
      expect(
        logs,
        hasLength(8),
      );

      for (var i = 8; i >= 0; i--) {
        await fancyLogger.startSession();
        await Future.delayed(const Duration(milliseconds: 500), () {});
        logs = (await fancyLogger.getAllLogsAsMaps()).where(
          (element) =>
              !(element['message']! as String).contains('Session start'),
        );
        expect(
          logs,
          hasLength(i),
        );
      }
    });
  });
}
