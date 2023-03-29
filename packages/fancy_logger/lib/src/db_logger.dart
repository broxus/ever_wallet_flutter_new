import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' as td;

import 'package:archive/archive_io.dart';
import 'package:fancy_logger/src/abstract_logger.dart';
import 'package:fancy_logger/src/models/writable_log_record.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

    Future.delayed(const Duration(milliseconds: 200), _cleanup);

    return 'new session id: $_sessionId';
  }

  @override
  void write(LogRecord record) {
    if (!_database.isOpen) return;

    _database.insert('records', record.toMap(sessionId: _sessionId));
  }

  /// Get all logs as strings
  Future<String> getAllLogsAsString() async {
    if (!_database.isOpen) return '';

    final list = await _database.rawQuery(
      '''
        SELECT * FROM records ORDER BY record_timestamp ASC
      ''',
    );
    return list.fold(
      '',
      (previousValue, element) => '$previousValue\n$element',
    );
  }

  /// Get all logs as [LogRecord]s (for debug purposes only)
  Future<List<LogRecord>> getAllLogs() async {
    if (!_database.isOpen) return [];

    final list = await _database.rawQuery(
      '''
        SELECT * FROM records ORDER BY record_timestamp ASC
      ''',
    );
    return list.map(WritableLogRecord.fromMap).toList();
  }

  /// Get all logs as maps (for debug purposes only)
  Future<List<Map<String, Object?>>> getAllLogsAsMaps() async {
    if (!_database.isOpen) return [];

    final list = await _database.rawQuery(
      '''
        SELECT * FROM records ORDER BY record_timestamp ASC
      ''',
    );
    return list;
  }

  /// Write logs to archived JSON, return file path
  Future<String> writeAllLogsToJson(String filename) async {
    if (!_database.isOpen) return 'Database is not ready';

    final cursor = await _database.rawQueryCursor(
      '''
        SELECT
          logger_name,
          id,
          record_timestamp,
          session_id,
          level,
          message,
          time
        FROM records ORDER BY record_timestamp ASC
      ''',
      [],
    );

    final fileAcrhive = _FileAcrhive();
    final filePath = await fileAcrhive.open(filename);

    await fileAcrhive.writeString('{\n  "logs": [\n');

    try {
      var isFirst = true;
      while (await cursor.moveNext()) {
        final row = cursor.current;
        final string = json.encode(row);
        final comma = isFirst ? '' : ',\n';
        await fileAcrhive.writeString('$comma    $string');
        isFirst = false;
      }
    } finally {
      await cursor.close();
    }

    await fileAcrhive.writeString('\n  ]\n}');

    await fileAcrhive.close();

    return filePath;
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

  /// Clear logs (for debug purposes only)
  Future<void> clearAllLogs() async {
    const query = '''
      DELETE FROM records;
    ''';

    await _database.execute(query);
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

const _binaryChunkSize = 1024 * 512;

class _FileAcrhive {
  _FileAcrhive();

  OutputFileStream? _outputFileStream;
  final encoder = BZip2Encoder();
  final bytesBuilder = td.BytesBuilder();

  Future<String> open(String filename) async {
    await close();

    final filePath = join(
      (await getTemporaryDirectory()).path,
      '$filename.bz2',
    );

    try {
      await File(filePath).delete();
    } catch (_) {}

    _outputFileStream = OutputFileStream(filePath);

    return filePath;
  }

  Future<void> close() async {
    _checkAndWriteBuffer(force: true);
    await _outputFileStream?.close();
    _outputFileStream = null;
  }

  Future<void> writeString(String string) async {
    bytesBuilder.add(utf8.encode(string));
    _checkAndWriteBuffer();
  }

  void _checkAndWriteBuffer({bool force = false}) {
    if ((force && bytesBuilder.isNotEmpty) ||
        bytesBuilder.length > _binaryChunkSize) {
      _outputFileStream?.writeBytes(
        encoder.encode(
          bytesBuilder.takeBytes(),
        ),
      );
    }
  }
}
