import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _browserPermissionsDomain = 'browser_permissions';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser permissions - related data.
@singleton
class BrowserPermissionsStorageService extends AbstractStorageService {
  BrowserPermissionsStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserPermissionsDomain;

  final GetStorage _storage;

  /// Get all permissions that user had granted to dapps.
  /// key - url address, value - permissions
  Map<String, Permissions> getPermissions() {
    final encoded = _storage.getEntries();

    return encoded.map(
      (key, value) => MapEntry(
        key,
        Permissions.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  /// Set permission for specified url
  void setPermissions({
    required String origin,
    required Permissions permissions,
  }) {
    _storage.write(origin, permissions.toJson());
  }

  /// Delete permissions for specified url
  void deletePermissionsForOrigin(String origin) {
    _storage.remove(origin);
  }

  /// Clear information about permissions
  Future<void> clearPermissions() {
    return _storage.erase();
  }

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearPermissions(),
      ]);

  @override
  Future<void> init() async {
    await GetStorage.init(container);
  }
}
