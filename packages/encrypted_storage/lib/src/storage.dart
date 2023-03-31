import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _defaultDomain = 'default';

/// {@template storage}
/// Storage (db backend)
/// {@endtemplate}
class Storage {
  /// {@macro storage}
  Storage();

  late final Database _database;
  final _log = Logger('EncryptedStorage: Storage');

  /// Init storage
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        'encrypted_storage.db',
      ),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE storage (
          domain TEXT NOT NULL,
          key TEXT NOT NULL,
          value TEXT NOT NULL,
          PRIMARY KEY (domain, key),
        );
      ''',
    );
    await db.execute(
      '''
        CREATE INDEX storage_domain_index ON storage(domain);
      ''',
    );
  }

  /// Clear storage: all records
  Future<void> clearAll() async {
    const query = '''
      DELETE FROM storage;
    ''';

    await _database.execute(query);
  }

  /// Clear storage: all records in one domain
  Future<void> clearDomain([String? domain = _defaultDomain]) async {
    final query = '''
      DELETE FROM storage WHERE domain = $domain;
    ''';

    await _database.execute(query);
  }

  /// Write the key-value pair. [value] will be written for the [key] in
  /// [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default)
  Future<void> set(
    String key,
    String value, {
    String domain = _defaultDomain,
    bool overwrite = true,
  }) async {
    return setDomain({key: value}, domain: domain, overwrite: overwrite);
  }

  /// Write the key-value pair map. [pairs] will be written in [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default). Unspecified in [pairs] in db will not be altered
  /// or deleted.
  Future<void> setDomain(
    Map<String, String> pairs, {
    String domain = _defaultDomain,
    bool overwrite = true,
  }) async {
    if (pairs.isEmpty) {
      _log.info('setAll called with empty pair map');
      return;
    }

    var isFirst = true;
    final values = pairs.entries.fold('', (previousValue, pair) {
      final prefix = isFirst ? '' : ', ';
      final result = '$prefix($domain, ${pair.key}, ${pair.value})';
      isFirst = false;
      return result;
    });

    final conflictClause = overwrite ? 'REPLACE' : 'IGNORE';
    final query = '''
      INSERT OR $conflictClause INTO storage (domain, key, value) VALUES $values;
    ''';

    await _database.execute(query);
  }

  /// Get value by [key] and [domain]. If not found will return [defaultValue]
  Future<String?> get(
    String key,
    String? defaultValue, {
    String domain = _defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
        SELECT value FROM storage WHERE domain = $domain and key = $key LIMIT 1;
      ''',
    );
    return list[0]['value'] as String? ?? defaultValue;
  }

  /// Get key-value pair map from [domain].
  Future<Map<String, String>> getDomain({
    String domain = _defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
        SELECT key, value FROM storage WHERE domain = $domain;
      ''',
    );

    return {
      // There is no way to write null in these fields
      // ignore: cast_nullable_to_non_nullable
      for (var pair in list) pair['key'] as String: pair['value'] as String
    };
  }
}
