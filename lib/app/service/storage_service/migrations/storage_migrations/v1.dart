import 'dart:convert';

import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/browser_bookmarks_storage_service.dart';
import 'package:app/app/service/storage_service/browser_favicon_url_storage_service.dart';
import 'package:app/app/service/storage_service/browser_history_storage_service.dart';
import 'package:app/app/service/storage_service/browser_permissions_storage_service.dart';
import 'package:app/app/service/storage_service/browser_tabs_storage_service.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

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
