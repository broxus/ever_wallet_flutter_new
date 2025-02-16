import 'dart:collection';

import 'package:app/feature/browserV2/service/storages/browser_favicon_url_storage_service.dart';
import 'package:elementary_helper/elementary_helper.dart';

class FaviconManager {
  FaviconManager(
    this._browserFaviconURLStorageService,
  );

  final _faviconsState = StateNotifier<FaviconData>(initValue: FaviconData._());

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  ListenableState<FaviconData> get faviconsState => _faviconsState;

  FaviconData get _cache => _faviconsState.value ?? FaviconData._();

  void dispose() {
    _faviconsState.dispose();
  }

  Future<void> fetchFavicon(
    Uri uri, {
    bool isReplace = false,
  }) async {
    if (isReplace && _cache.checkExist(uri)) {
      return;
    }

    final faviconUrl =
        await _browserFaviconURLStorageService.getFaviconURL(uri);

    if (faviconUrl == null) {
      return;
    }

    _faviconsState.accept(
      _cache.upgrade(uri, faviconUrl),
    );
  }
}

class FaviconData {
  FaviconData._([
    HashMap<Uri, String>? cache,
  ]) : _cache = cache ?? HashMap();

  final HashMap<Uri, String> _cache;

  bool checkExist(Uri key) => _cache[key] != null;

  String getSafe(Uri key) => _cache[key] ?? '';

  FaviconData upgrade(Uri uri, String faviconUrl) {
    _cache[uri] = faviconUrl;
    return FaviconData._(_cache);
  }
}
