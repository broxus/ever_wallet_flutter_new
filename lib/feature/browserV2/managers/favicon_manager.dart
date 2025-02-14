import 'package:app/app/service/storage_service/browser_favicon_url_storage_service.dart';

class FaviconManager {
  FaviconManager(
    this._browserFaviconURLStorageService,
  );

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  Future<String?> getFaviconURL(Uri uri) {
    return _browserFaviconURLStorageService.getFaviconURL(uri);
  }
}
