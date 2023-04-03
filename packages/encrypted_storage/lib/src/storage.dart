import 'dart:async';

import 'package:encrypted_storage/src/abstract_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// {@template storage}
/// Storage (db backend)
/// {@endtemplate}
class Storage implements AbstractStorage {
  /// {@macro storage}
  Storage();

  late final Database _database;
  final _log = Logger('EncryptedStorage: Storage');

  /// Init storage
  Future<void> init([String dbName = 'storage.db']) async {
    WidgetsFlutterBinding.ensureInitialized();

    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        dbName,
      ),
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
      version: 1,
    );

    _log.finest('initialized');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE storage (
          domain TEXT NOT NULL,
          key TEXT NOT NULL,
          value TEXT NOT NULL,
          PRIMARY KEY (domain, key)
        );
      ''',
    );
    await db.execute(
      '''
        CREATE INDEX storage_domain_index ON storage(domain);
      ''',
    );

    _log.finest('database created');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    _log
      ..finest('database upgraded from $oldVersion to $newVersion')
      ..warning('no upgrade migrations found');
  }

  FutureOr<void> _onDowngrade(Database db, int oldVersion, int newVersion) {
    _log
      ..finest('database downgraded from $oldVersion to $newVersion')
      ..warning('no downgrade migrations found');
  }

  /// Clear storage: all records
  @override
  Future<void> clearAll() async {
    const query = '''
      DELETE FROM storage;
    ''';

    await _database.execute(query);

    _log.finest('storage cleared');
  }

  /// Clear storage: all records in one domain
  @override
  Future<void> clearDomain([String? domain = defaultDomain]) async {
    final query = '''
      DELETE FROM storage WHERE domain = "$domain";
    ''';

    await _database.execute(query);

    _log.finest('domain $domain cleared');
  }

  /// Write the key-value pair. [value] will be written for the [key] in
  /// [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default)
  @override
  Future<void> set(
    String key,
    String value, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) async {
    return setDomain({key: value}, domain: domain, overwrite: overwrite);
  }

  /// Write the key-value pair map. [pairs] will be written in [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default). Unspecified in [pairs] in db will not be altered
  /// or deleted.
  @override
  Future<void> setDomain(
    Map<String, String> pairs, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) async {
    if (pairs.isEmpty) {
      _log.info('setAll called with empty pair map');
      return;
    }

    var isFirst = true;
    final values = pairs.entries.fold('', (previousValue, pair) {
      final prefix = isFirst ? '' : ', ';
      final result =
          '$previousValue$prefix("$domain", "${pair.key}", "${pair.value}")';
      isFirst = false;
      return result;
    });

    final conflictClause = overwrite ? 'REPLACE' : 'IGNORE';
    final query = '''
      INSERT OR $conflictClause INTO storage (domain, key, value) VALUES $values;
    ''';

    await _database.execute(query);
  }

  /// Delete by [key] from [domain].
  @override
  Future<void> delete(
    String key, {
    String domain = defaultDomain,
  }) async {
    return deleteDomain([key], domain: domain);
  }

  /// Delete by [keys] from [domain].
  @override
  Future<void> deleteDomain(
    List<String> keys, {
    String domain = defaultDomain,
  }) async {
    if (keys.isEmpty) {
      _log.info('deleteDomain called with empty key list');
      return;
    }

    if (keys.length > 512) {
      _log.warning(
        'deleteDomain: key list is too long: ${keys.length}',
      );
    }

    var isFirst = true;
    final andClause = keys.fold('', (previousValue, key) {
      final prefix = isFirst ? '' : ' OR ';
      final result = '$previousValue$prefix(key = "$key")';
      isFirst = false;
      return result;
    });

    final query = '''
      DELETE FROM storage WHERE domain = "$domain" AND ($andClause)
    ''';

    await _database.execute(query);
  }

  /// Get value by [key] and [domain]. If not found will return [defaultValue]
  @override
  Future<String?> get(
    String key, {
    String? defaultValue,
    String domain = defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
        SELECT value FROM storage WHERE domain = "$domain" and key = "$key" LIMIT 1;
      ''',
    );

    return list.isNotEmpty ? list.first['value'] as String? : defaultValue;
  }

  /// Get key-value pair map from [domain].
  @override
  Future<Map<String, String>> getDomain({
    String domain = defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
        SELECT key, value FROM storage WHERE domain = "$domain";
      ''',
    );

    return {
      // There is no way to write null in these fields
      // ignore: cast_nullable_to_non_nullable
      for (var pair in list) pair['key'] as String: pair['value'] as String
    };
  }
}
