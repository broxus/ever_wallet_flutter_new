import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v1.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v2.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v3.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v4.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';

final _logger = Logger('StorageMigrationService');

const _version = 4;
const _versionKey = 'version';

class StorageMigrationService {
  StorageMigrationService(
    this._encryptedStorage,
    this._presetsConnectionService,
  ) : _storage = GetStorage();

  static Future<void> applyMigrations(
    EncryptedStorage encryptedStorage,
    PresetsConnectionService presetsConnectionService,
  ) async =>
      StorageMigrationService(
        encryptedStorage,
        presetsConnectionService,
      ).migrate();

  final GetStorage _storage;
  final EncryptedStorage _encryptedStorage;

  final PresetsConnectionService _presetsConnectionService;

  int get currentVersion => _storage.read<int>(_versionKey) ?? 0;

  bool get needMigration => currentVersion < _version;

  Future<void> migrate() async {
    await GetStorage.init();

    if (!needMigration) return;

    final migrations = _getMigrations();

    try {
      for (final migration in migrations) {
        await migration.apply();
        await migration.complete();
      }
    } catch (e, t) {
      _logger.severe('migrate', e, t);
    } finally {
      await _storage.write(_versionKey, _version);
    }
  }

  Iterable<StorageMigration> _getMigrations() sync* {
    if (currentVersion < StorageMigrationV1.version) {
      yield StorageMigrationV1(encryptedStorage: _encryptedStorage);
    }
    if (currentVersion < StorageMigrationV2.version) {
      yield StorageMigrationV2();
    }
    if (currentVersion < StorageMigrationV3.version) {
      yield StorageMigrationV3();
    }
    if (currentVersion < StorageMigrationV4.version) {
      yield StorageMigrationV4(
        _presetsConnectionService,
      );
    }
  }
}
