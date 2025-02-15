import 'package:app/data/models/permissions.dart';
import 'package:app/feature/browserV2/service/storages/browser_permissions_storage_service.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class PermissionsManager {
  PermissionsManager(
    this._browserPermissionsStorageService,
  );

  final BrowserPermissionsStorageService _browserPermissionsStorageService;

  /// Subject for permissions of browser tabs
  final _permissionsSubject =
      BehaviorSubject<Map<String, Permissions>>.seeded({});

  //// Get cached permissions from storage
  /// key - url address, value - permissions
  Map<String, Permissions> get permissions => _permissionsSubject.value;

  /// Stream that allows tracking permissions changing
  Stream<Map<String, Permissions>> get permissionsStream => _permissionsSubject;

  void init() {
    _fetchPermissions();
  }

  Future<void> clear() {
    return clearPermissions();
  }

  /// Set permission for specified url
  void setPermissions({
    required String origin,
    required Permissions permissions,
  }) {
    _browserPermissionsStorageService.setPermissions(
      origin: origin,
      permissions: permissions,
    );

    _fetchPermissions();
  }

  void deletePermissionsForOrigin(String origin) {
    _browserPermissionsStorageService.deletePermissionsForOrigin(origin);
    _fetchPermissions();
  }

  /// Delete permissions for specified account
  void deletePermissionsForAccount(Address address) {
    final perms = permissions;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      _browserPermissionsStorageService.setPermissions(
        origin: origin,
        permissions: permissions,
      );
    }

    _fetchPermissions();
  }

  /// Clear information about permissions
  Future<void> clearPermissions() async {
    await _browserPermissionsStorageService.clearPermissions();
    _permissionsSubject.add({});
  }

  void _fetchPermissions() => _permissionsSubject.add(
        _browserPermissionsStorageService.getPermissions(),
      );
}
