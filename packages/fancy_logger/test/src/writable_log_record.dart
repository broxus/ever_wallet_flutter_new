// ignore_for_file: prefer_const_constructors

import 'package:fancy_logger/fancy_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  group('WritableLogRecord extension for LogRecord', () {
    test('to map', () {
      final map =
          LogRecord(Level.CONFIG, 'msg12', 'logger34').toMap(sessionId: 42);
      expect(map, {
        'session_id': 42,
        'level': Level.CONFIG.value,
        'message': 'msg12',
        'logger_name': 'logger34',
        'time': map['time'], // can't check it really
      });
    });

    test('from map', () {
      final originalMap = {
        'session_id': 42,
        'level': Level.CONFIG.value,
        'message': 'msg12',
        'logger_name': 'logger34',
      };

      final convertedMap =
          WritableLogRecord.fromMap(originalMap).toMap(sessionId: 42);

      expect(convertedMap, {...originalMap, 'time': convertedMap['time']});
    });
  });
}
