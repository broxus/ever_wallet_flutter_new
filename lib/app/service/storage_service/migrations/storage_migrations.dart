import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
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

class StorageMigrationV3 implements StorageMigration {
  static const int version = 3;

  @override
  Future<void> apply() async {
    final containers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];

    for (final container in containers) {
      await GetStorage.init(container);

      final storage = GetStorage(container);
      final encoded = storage.getEntries();

      for (final entry in encoded.entries) {
        try {
          final key = _NetworkType.from(entry.key);
          final value = entry.value;

          await storage.write(key.toString(), value);
        } catch (_) {
          await storage.remove(entry.key);
        }
      }
    }
  }

  @override
  Future<void> complete() async {}
}

enum _NetworkType {
  ever,
  venom,
  tycho,
  ton,
  custom;

  factory _NetworkType.from(String value) =>
      int.tryParse(value)?.let(
        (index) => index < _NetworkType.values.length
            ? _NetworkType.values[index]
            : null,
      ) ??
      _NetworkType.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => _NetworkType.custom,
      );
}
