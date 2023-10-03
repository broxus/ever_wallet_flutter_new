import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:favicon/favicon.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

const _browserFaviconURLDomain = 'browser_favicon_urls';

final _suffixes = ['png', 'ico'];

@singleton
class BrowserFaviconURLStorageService extends AbstractStorageService {
  BrowserFaviconURLStorageService(this._storage);

  static final _log = Logger('BrowserFaviconURLStorageService');

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  Future<String?> getFaviconURL(Uri uri) async {
    final url = uri.toString();
    final cached = await _storage.get(
      url,
      domain: _browserFaviconURLDomain,
    );
    if (cached != null) {
      return cached;
    }

    final iconUrl =
        (await FaviconFinder.getBest(url, suffixes: _suffixes))?.url;
    if (iconUrl == null) {
      _log.info('No favicon found for $url');

      return null;
    }

    unawaited(
      _storage.set(
        url,
        iconUrl,
        domain: _browserFaviconURLDomain,
      ),
    );

    return iconUrl;
  }

  @override
  Future<void> clearSensitiveData() async {
    await _storage.clearDomain(_browserFaviconURLDomain);
  }

  @override
  Future<void> init() async {}
}
