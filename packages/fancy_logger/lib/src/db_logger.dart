import 'dart:async';

import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:fancy_logger/src/models/writable_log_record.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Database logger
class DbLogger extends AbstractLogger {
  late final Database _database;
  late final Map<Level, int> _retainStrategy;
  int _sessionId = -1;

  @override
  Future<void> init(Map<Level, int> retainStrategy) async {
    WidgetsFlutterBinding.ensureInitialized();

    _retainStrategy = retainStrategy;

    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        'logs.db',
      ),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
        );
      ''',
    );
    await db.execute(
      '''
        CREATE TABLE records (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          record_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          session_id INTEGER,
          level INTEGER,
          message TEXT,
          logger_name TEXT,
          time TIMESTAMP
        );
      ''',
    );
  }

  @override
  Future<String?> sessionStart() async {
    await _database.transaction((txn) async {
      _sessionId = await txn.rawInsert(
        '''INSERT INTO sessions DEFAULT VALUES;''',
      );
    });

    Future.delayed(const Duration(seconds: 1), _cleanup);

    return 'new session id: $_sessionId';
  }

  @override
  void write(LogRecord record) {
    if (!_database.isOpen) return;

    _database.insert('records', record.toMap(sessionId: _sessionId));
  }

  /// Get all logs as strings (for debug purposes only)
  Future<String> getAllLogs() async {
    if (!_database.isOpen) return '';

    final list = await _database.rawQuery(
      '''
        SELECT * from records ORDER BY record_timestamp ASC
      ''',
    );
    return list.fold(
      '',
      (previousValue, element) => '$previousValue\n$element',
    );
  }

  Future<void> _cleanup() async {
    if (!_database.isOpen || _sessionId < 0 || _retainStrategy.isEmpty) return;

    final levelList = _retainStrategy.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    Level? nextLevel;
    var retain = _sessionId;
    final leveListWithBouds = levelList
        .map(
          (e) {
            final ret = _LevelBound(
              level: e.key,
              nextLevel: nextLevel,
              sessionId: e.value,
            );
            nextLevel = e.key;
            return ret;
          },
        )
        .toList()
        .reversed
        .map((e) {
          retain -= e.sessionId;
          return e.copyWith(sessionId: retain);
        })
        .toList();

    final where = leveListWithBouds.fold('', (previousValue, element) {
      final previous = previousValue.isNotEmpty ? '$previousValue OR ' : '';
      final next = element.nextLevel == null
          ? ''
          : 'AND level < ${element.nextLevel!.value}';
      return '''
        $previous(session_id < ${element.sessionId} AND level >= ${element.level.value} $next)
        ''';
    });

    final query = '''
      DELETE FROM records WHERE $where;
    ''';

    unawaited(_database.execute(query));
  }
}

class _LevelBound {
  _LevelBound({
    required this.level,
    required this.nextLevel,
    required this.sessionId,
  });
  final Level level;
  final Level? nextLevel;
  final int sessionId;

  _LevelBound copyWith({int? sessionId}) => _LevelBound(
        level: level,
        nextLevel: nextLevel,
        sessionId: sessionId ?? this.sessionId,
      );
}
