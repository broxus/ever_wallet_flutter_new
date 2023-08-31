import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _browserPermissionsDomain = 'browser_permissions';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser permissions - related data.
@singleton
class BrowserPermissionsStorageService extends AbstractStorageService {
  BrowserPermissionsStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  /// Subject for permissions of browser tabs
  final _permissionsSubject =
      BehaviorSubject<Map<String, Permissions>>.seeded({});

  //// Get cached permissions from storage
  /// key - url address, value - permissions
  Map<String, Permissions> get permissions => _permissionsSubject.value;

  /// Stream that allows tracking permissions changing
  Stream<Map<String, Permissions>> get permissionsStream => _permissionsSubject;

  /// Put browser bookmarks items to stream
  Future<void> _streamedPermissions() async =>
      _permissionsSubject.add(await readPermissions());

  /// Get all permissions that user had granted to dapps.
  /// key - url address, value - permissions
  Future<Map<String, Permissions>> readPermissions() async {
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
  }) async {
    await _storage.set(
      origin,
      jsonEncode(permissions.toJson()),
      domain: _browserPermissionsDomain,
    );
    await _streamedPermissions();
  }

  /// Delete permissions for specified url
  Future<void> deletePermissionsForOrigin(String origin) async {
    await _storage.delete(origin, domain: _browserPermissionsDomain);
    await _streamedPermissions();
  }

  /// Delete permissions for specified account
  Future<void> deletePermissionsForAccount(Address address) async {
    final perms = permissions;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      await setPermissions(origin: origin, permissions: permissions);
    }
    await _streamedPermissions();
  }

  /// Clear information about permissions
  Future<void> clearPermissions() async {
    await _storage.clearDomain(_browserPermissionsDomain);
    await _streamedPermissions();
  }

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearPermissions(),
      ]);

  @override
  Future<void> init() => Future.wait([
        _streamedPermissions(),
      ]);
}
