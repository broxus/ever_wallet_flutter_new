import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:fancy_logger/src/models/writable_log_record.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Database logger
class DbLogger extends AbstractLogger {
  late final Database _database;
  int _sessionId = -1;

  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

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
      _sessionId = await txn.rawInsert('INSERT INTO sessions DEFAULT VALUES;');
    });

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

    final list = await _database.rawQuery('SELECT * from records');
    return list.fold(
      '',
      (previousValue, element) => '$previousValue\n$element',
    );
  }
}
