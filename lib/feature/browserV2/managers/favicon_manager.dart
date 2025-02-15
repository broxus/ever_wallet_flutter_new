import 'package:app/feature/browserV2/service/storages/browser_favicon_url_storage_service.dart';

class FaviconManager {
  FaviconManager(
    this._browserFaviconURLStorageService,
  );

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  Future<String?> getFaviconURL(Uri uri) {
    return _browserFaviconURLStorageService.getFaviconURL(uri);
  }
}
