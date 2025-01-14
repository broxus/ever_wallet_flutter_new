import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:favicon/favicon.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

const _browserFaviconURLDomain = 'browser_favicon_urls';

final _suffixes = ['png', 'ico'];

@singleton
class BrowserFaviconURLStorageService extends AbstractStorageService {
  BrowserFaviconURLStorageService(
    @Named(container) this._storage,
  );

  static final _log = Logger('BrowserFaviconURLStorageService');

  static const container = _browserFaviconURLDomain;

  final GetStorage _storage;

  Future<String?> getFaviconURL(Uri uri) async {
    final url = uri.toString();
    final cached = _storage.read<String>(url);
    if (cached != null) {
      return cached;
    }

    final iconUrl =
        (await FaviconFinder.getBest(url, suffixes: _suffixes))?.url;
    if (iconUrl == null) {
      _log.info('No favicon found for $url');

      return null;
    }

    unawaited(_storage.write(url, iconUrl));

    return iconUrl;
  }

  @override
  Future<void> clear() async {
    try {
      return await _storage.erase();
    } catch (_) {}
  }

  @override
  // ignore: no-empty-block
  Future<void> init() async {}
}
