// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:fancy_logger/fancy_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  final log = Logger('TestLogger');

  test('FancyLogger console tests', () async {
    final logs = <Map<String, dynamic>>[];

    void consoleLoggerCallback(
      String message, {
      DateTime? time,
      int? sequenceNumber,
      int level = 0,
      String name = '',
      Zone? zone,
      Object? error,
      StackTrace? stackTrace,
    }) {
      if (!message.contains('hot-reload')) {
        logs.add({
          'message': message,
          'level': level,
          'name': name,
        });
      }
    }

    final fancyLogger = FancyLogger();
    await fancyLogger.init(
      {},
      startNewSession: false,
      dbLogger: false,
      consoleLoggerCallback: consoleLoggerCallback,
    );

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

    expect(logs, hasLength(9));

    expect(logs[0]['message'], contains('Session start'));
    expect(logs[0]['name'], contains('FancyLogger'));

    expect(logs[1]['message'], contains(ConsoleColor.green.value));
    expect(logs[1]['message'], contains('some finest log'));
    expect(logs[1]['message'], contains(ConsoleColor.reset.value));
    expect(logs[1]['name'], contains('TestLogger'));
    expect(logs[1]['level'], Level.FINEST.value);

    expect(logs[2]['message'], contains(ConsoleColor.green.value));
    expect(logs[2]['message'], contains('some finer log'));
    expect(logs[2]['message'], contains(ConsoleColor.reset.value));
    expect(logs[2]['name'], contains('TestLogger'));
    expect(logs[2]['level'], Level.FINER.value);

    expect(logs[3]['message'], contains(ConsoleColor.green.value));
    expect(logs[3]['message'], contains('some fine log'));
    expect(logs[3]['message'], contains(ConsoleColor.reset.value));
    expect(logs[3]['name'], contains('TestLogger'));
    expect(logs[3]['level'], Level.FINE.value);

    expect(logs[4]['message'], contains(ConsoleColor.blue.value));
    expect(logs[4]['message'], contains('some config log'));
    expect(logs[4]['message'], contains(ConsoleColor.reset.value));
    expect(logs[4]['name'], contains('TestLogger'));
    expect(logs[4]['level'], Level.CONFIG.value);

    expect(logs[5]['message'], contains(ConsoleColor.cyan.value));
    expect(logs[5]['message'], contains('some info log'));
    expect(logs[5]['message'], contains(ConsoleColor.reset.value));
    expect(logs[5]['name'], contains('TestLogger'));
    expect(logs[5]['level'], Level.INFO.value);

    expect(logs[6]['message'], contains(ConsoleColor.yellow.value));
    expect(logs[6]['message'], contains('some warning log'));
    expect(logs[6]['message'], contains(ConsoleColor.reset.value));
    expect(logs[6]['name'], contains('TestLogger'));
    expect(logs[6]['level'], Level.WARNING.value);

    expect(logs[7]['message'], contains(ConsoleColor.red.value));
    expect(logs[7]['message'], contains('some severe log'));
    expect(logs[7]['message'], contains(ConsoleColor.reset.value));
    expect(logs[7]['name'], contains('TestLogger'));
    expect(logs[7]['level'], Level.SEVERE.value);

    expect(logs[8]['message'], contains(ConsoleColor.red.value));
    expect(logs[8]['message'], contains('some shout log'));
    expect(logs[8]['message'], contains(ConsoleColor.reset.value));
    expect(logs[8]['name'], contains('TestLogger'));
    expect(logs[8]['level'], Level.SHOUT.value);
  });
}
