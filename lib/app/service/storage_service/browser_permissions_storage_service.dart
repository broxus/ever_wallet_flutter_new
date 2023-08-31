import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _browserPermissionsDomain = 'browser_permissions';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser permissions - related data.
@singleton
class BrowserPermissionsStorageService extends AbstractStorageService {
  BrowserPermissionsStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  /// Get all permissions that user had granted to dapps.
  /// key - url address, value - permissions
  Future<Map<String, Permissions>> get permissions async {
    final encoded = await _storage.getDomain(domain: _browserPermissionsDomain);

    return encoded.map(
      (key, value) => MapEntry(
        key,
        Permissions.fromJson(jsonDecode(value) as Map<String, dynamic>),
      ),
    );
  }

  /// Set permission for specified url
  Future<void> setPermissions({
    required String origin,
    required Permissions permissions,
  }) =>
      _storage.set(
        origin,
        jsonEncode(permissions.toJson()),
        domain: _browserPermissionsDomain,
      );

  /// Delete permissions for specified url
  Future<void> deletePermissionsForOrigin(String origin) =>
      _storage.delete(origin, domain: _browserPermissionsDomain);

  /// Delete permissions for specified account
  Future<void> deletePermissionsForAccount(Address address) async {
    final perms = await permissions;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      await setPermissions(origin: origin, permissions: permissions);
    }
  }

  /// Clear information about permissions
  Future<void> clearPermissions() =>
      _storage.clearDomain(_browserPermissionsDomain);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearPermissions(),
      ]);

  @override
  // ignore: no-empty-block
  Future<void> init() async {}
}
