import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Database logger
class DbLogger extends AbstractLogger {
  late final Database _database;
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

  void _onCreate(Database db, int version) {
    db.execute(
      '''
        CREATE TABLE sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
        );
      ''',
    );
  }

  @override
  Future<String?> sessionStart() async {
    var sessionId = -1;
    await _database.transaction((txn) async {
      sessionId = await txn.rawInsert('INSERT INTO sessions DEFAULT VALUES;');
    });
    return 'new session id: $sessionId';
  }

  @override
  void write(LogRecord record) {}
}
