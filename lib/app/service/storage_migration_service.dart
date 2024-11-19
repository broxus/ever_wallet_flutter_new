import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';

final _logger = Logger('StorageMigrationService');
const _version = 1;
const _versionKey = 'version';

class StorageMigrationService {
  StorageMigrationService(
    this._encryptedStorage,
  )   : _storage = GetStorage(),
        _fss = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  static Future<void> migrateToContainers(
    EncryptedStorage encryptedStorage,
  ) async =>
      StorageMigrationService(
        encryptedStorage,
      ).migrate();

  final GetStorage _storage;
  final FlutterSecureStorage _fss;
  final EncryptedStorage _encryptedStorage;

  bool get needMigration => _storage.read<int>(_versionKey) == null;

  List<String> get _domains => [
        ...GeneralStorageService.containers,
        ...BalanceStorageService.containers,
        ConnectionsStorageService.container,
        BrowserBookmarksStorageService.container,
        BrowserFaviconURLStorageService.container,
        BrowserHistoryStorageService.container,
        BrowserPermissionsStorageService.container,
        BrowserTabsStorageService.container,
      ];

  Future<void> migrate() async {
    await GetStorage.init();

    if (needMigration) {
      try {
        await _applyMigration();
        await _completeMigration();
      } catch (e, t) {
        _logger.severe('migrate()', e, t);
        rethrow;
      }
    } else {
      await _completeMigration();
    }
  }

  Future<void> _applyMigration() async {
    await _migrateAppStorageService();

    for (final domain in _domains) {
      await _migrateEncryptedStorageDomain(domain);
    }
  }

  Future<void> _completeMigration() async {
    for (final entry in (await _fss.readAll()).entries) {
      if (entry.key.startsWith('sparx:')) {
        await _fss.delete(key: entry.key);
      }
    }

    for (final domain in _domains) {
      await _encryptedStorage.clearDomain(domain);
    }

    await _storage.write(_versionKey, _version);
  }

  Future<void> _migrateAppStorageService() async {
    await GetStorage.init(AppStorageService.container);
    final storage = GetStorage(AppStorageService.container);

    for (final entry in (await _fss.readAll()).entries) {
      if (entry.key.startsWith('sparx:')) {
        final value = bool.tryParse(entry.value) ?? entry.value;

        await storage.write(entry.key, value);
      }
    }
  }

  Future<void> _migrateEncryptedStorageDomain(String domain) async {
    await GetStorage.init(domain);
    final storage = GetStorage(domain);

    final encoded = await _encryptedStorage.getDomain(domain: domain);

    for (final entry in encoded.entries) {
      storage.writeInMemory(entry.key, _tryDecode(entry.value));
    }

    await storage.save();
  }

  dynamic _tryDecode(String value) {
    try {
      final decoded = jsonDecode(value);
      return decoded;
    } catch (_) {}
    return value;
  }
}
