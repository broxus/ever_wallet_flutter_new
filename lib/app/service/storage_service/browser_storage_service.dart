import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _permissionsKey = 'permissions_key';

const _siteMetaDataKey = 'site_meta_data_key';
const _browserNeedKey = 'browser_need_key';
const _browserPreferencesKey = 'browser_preferences_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser-related data.
@singleton
class BrowserStorageService extends AbstractStorageService {
  BrowserStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.wait([]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearPreferences(),
        clearSitesMetaData(),
        clearPermissions(),
      ]);

  /// Get all permissions that user had granted to dapps.
  /// key - url address, value - permissions
  Future<Map<String, Permissions>> get permissions async {
    final encoded = await _storage.getDomain(domain: _permissionsKey);

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
        domain: _permissionsKey,
      );

  /// Delete permissions for specified url
  Future<void> deletePermissionsForOrigin(String origin) =>
      _storage.delete(origin, domain: _permissionsKey);

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
  Future<void> clearPermissions() => _storage.clearDomain(_permissionsKey);

  /// Get metadata of site by its url
  Future<SiteMetaData?> getSiteMetaData(String url) async {
    final encoded = await _storage.get(url, domain: _siteMetaDataKey);
    if (encoded == null) {
      return null;
    }

    return SiteMetaData.fromJson(
      jsonDecode(encoded) as Map<String, dynamic>,
    );
  }

  /// Add metadata of site by its url
  Future<void> addSiteMetaData({
    required String url,
    required SiteMetaData metaData,
  }) =>
      _storage.set(
        url,
        jsonEncode(metaData.toJson()),
        domain: _siteMetaDataKey,
      );

  /// Clear all sites metadata
  Future<void> clearSitesMetaData() => _storage.clearDomain(_siteMetaDataKey);

  /// Get flag if Why Need Browser screen was shown
  Future<bool> get getWhyNeedBrowser async {
    final encoded = await _storage.get(
      _browserNeedKey,
      domain: _browserPreferencesKey,
    );

    return jsonDecode(encoded ?? 'false') as bool;
  }

  /// Set flag that Why Need Browser screen was shown
  Future<void> saveWhyNeedBrowser() => _storage
      .set(_browserNeedKey, jsonEncode(true), domain: _browserPreferencesKey);

  /// Clear information about all preferences
  Future<void> clearPreferences() =>
      _storage.clearDomain(_browserPreferencesKey);
}
