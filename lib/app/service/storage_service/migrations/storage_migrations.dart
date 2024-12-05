import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

abstract interface class StorageMigration {
  Future<void> apply();

  Future<void> complete();
}

class StorageMigrationV1 implements StorageMigration {
  StorageMigrationV1({
    required this.encryptedStorage,
  }) : fss = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  static const int version = 1;

  final FlutterSecureStorage fss;
  final EncryptedStorage encryptedStorage;

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

  @override
  Future<void> apply() async {
    await _migrateAppStorageService();

    for (final domain in _domains) {
      await _migrateEncryptedStorageDomain(domain);
    }
  }

  @override
  Future<void> complete() async {
    for (final entry in (await fss.readAll()).entries) {
      if (entry.key.startsWith('sparx:')) {
        await fss.delete(key: entry.key);
      }
    }

    for (final domain in _domains) {
      await encryptedStorage.clearDomain(domain);
    }
  }

  Future<void> _migrateAppStorageService() async {
    await GetStorage.init(AppStorageService.container);
    final storage = GetStorage(AppStorageService.container);

    for (final entry in (await fss.readAll()).entries) {
      if (entry.key.startsWith('sparx:')) {
        final value = bool.tryParse(entry.value) ?? entry.value;

        await storage.write(entry.key, value);
      }
    }
  }

  Future<void> _migrateEncryptedStorageDomain(String domain) async {
    await GetStorage.init(domain);
    final storage = GetStorage(domain);

    final encoded = await encryptedStorage.getDomain(domain: domain);

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

class StorageMigrationV2 implements StorageMigration {
  static const int version = 2;

  @override
  Future<void> apply() async {
    for (final container in BalanceStorageService.containers) {
      await GetStorage.init(container);
      await GetStorage(container).erase();
    }
  }

  @override
  Future<void> complete() async {}
}
