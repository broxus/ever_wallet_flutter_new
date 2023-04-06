import 'dart:async';

import 'package:collection/collection.dart';
import 'package:encrypted_storage/src/abstract_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// {@template storage}
/// Storage (db backend)
/// {@endtemplate}
class Storage {
  /// {@macro storage}
  Storage();

  late final Database _database;
  final _log = Logger('EncryptedStorage: Storage');

  static const _storageFileName = 'storage.db';

  /// Init storage
  Future<void> init([String dbName = _storageFileName]) async {
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

  /// Reset storage
  Future<void> reset([String dbName = _storageFileName]) async {
    WidgetsFlutterBinding.ensureInitialized();

    await deleteDatabase(
      join(
        await getDatabasesPath(),
        dbName,
      ),
    );

    _log.finest('reset');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE storage (
          domain TEXT NOT NULL,
          key TEXT NOT NULL,
          value TEXT NOT NULL,
          iv TEXT NOT NULL,
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
  Future<void> clearAll() async {
    const query = '''
      DELETE FROM storage;
    ''';

    await _database.execute(query);

    _log.finest('storage cleared');
  }

  /// Clear storage: all records in one domain
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
  Future<void> set(
    String key,
    StorageValue value, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) async {
    return setDomain(
      {
        key: value,
      },
      domain: domain,
      overwrite: overwrite,
    );
  }

  /// Write the key-value pair map. [pairs] will be written in [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default). Unspecified in [pairs] in db will not be altered
  /// or deleted.
  Future<void> setDomain(
    Map<String, StorageValue> pairs, {
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
          // ignore: lines_longer_than_80_chars
          '$previousValue$prefix("$domain", "${pair.key}", "${pair.value.value}", "${pair.value.iv}" )';
      isFirst = false;
      return result;
    });

    final conflictClause = overwrite ? 'REPLACE' : 'IGNORE';
    final query = '''
      INSERT OR $conflictClause INTO storage (domain, key, value, iv) VALUES $values;
    ''';

    await _database.execute(query);
  }

  /// Delete by [key] from [domain].
  Future<void> delete(
    String key, {
    String domain = defaultDomain,
  }) async {
    return deleteDomain([key], domain: domain);
  }

  /// Delete by [keys] from [domain].
  Future<void> deleteDomain(
    List<String> keys, {
    String domain = defaultDomain,
  }) async {
    if (keys.isEmpty) {
      _log.info('deleteDomain called with empty key list');
      return;
    }

    // SQLite has a limit of 999 variables per query
    keys.slices(512).forEach((keys) async {
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
    });
  }

  /// Get value by [key] and [domain]. If not found will return [defaultValue]
  Future<StorageValue?> get(
    String key, {
    StorageValue? defaultValue,
    String domain = defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
        SELECT value, iv FROM storage WHERE domain = "$domain" and key = "$key" LIMIT 1;
      ''',
    );

    return list.isNotEmpty
        ? StorageValue(
            list.first['value']! as String,
            list.first['iv']! as String,
          )
        : defaultValue;
  }

  /// Get key-value pair map from [domain].
  Future<Map<String, StorageValue>> getDomain({
    String domain = defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
        SELECT key, value, iv FROM storage WHERE domain = "$domain";
      ''',
    );

    return {
      // There is no way to write null in these fields
      // ignore: cast_nullable_to_non_nullable
      for (var pair in list)
        pair['key']! as String: StorageValue(
          pair['value']! as String,
          pair['iv']! as String,
        )
    };
  }

  /// Get keys from [domain]
  Future<List<String>> getDomainKeys({
    String domain = defaultDomain,
  }) async {
    final list = await _database.rawQuery(
      '''
      SELECT key FROM storage WHERE domain = "$domain";
    ''',
    );

    return [
      // There is no way to write null in these fields
      // ignore: cast_nullable_to_non_nullable
      for (var pair in list) pair['key']! as String
    ];
  }
}

/// {@template storage_value}
/// Storage value unit
/// {@endtemplate}
@immutable
class StorageValue implements Comparable<StorageValue> {
  /// {@macro storage_value}
  const StorageValue(this.value, this.iv);

  /// Value
  final String value;

  /// Initialization vector
  final String iv;

  @override
  int compareTo(StorageValue other) {
    return (value.compareTo(other.value) == 0 && iv.compareTo(other.iv) == 0)
        ? 0
        : 1;
  }

  @override
  bool operator ==(Object other) {
    return other is StorageValue && other.value == value && other.iv == iv;
  }

  @override
  int get hashCode {
    return value.hashCode + iv.hashCode;
  }
}
