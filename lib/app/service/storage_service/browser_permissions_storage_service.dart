import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

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

  /// Subject for permissions of browser tabs
  final _permissionsSubject =
      BehaviorSubject<Map<String, Permissions>>.seeded({});

  //// Get cached permissions from storage
  /// key - url address, value - permissions
  Map<String, Permissions> get permissions => _permissionsSubject.value;

  /// Stream that allows tracking permissions changing
  Stream<Map<String, Permissions>> get permissionsStream => _permissionsSubject;

  /// Put browser bookmarks items to stream
  void _streamedPermissions() => _permissionsSubject.add(readPermissions());

  /// Get all permissions that user had granted to dapps.
  /// key - url address, value - permissions
  Map<String, Permissions> readPermissions() {
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
    _streamedPermissions();
  }

  /// Delete permissions for specified url
  void deletePermissionsForOrigin(String origin) {
    _storage.remove(origin);
    _streamedPermissions();
  }

  /// Delete permissions for specified account
  void deletePermissionsForAccount(Address address) {
    final perms = permissions;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      setPermissions(origin: origin, permissions: permissions);
    }

    _streamedPermissions();
  }

  /// Clear information about permissions
  Future<void> clearPermissions() async {
    await _storage.erase();
    _streamedPermissions();
  }

  @override
  Future<void> clear() async {
    _permissionsSubject.add({});
    try {
      await _storage.erase();
    } catch (_) {}
  }

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedPermissions();
  }
}
