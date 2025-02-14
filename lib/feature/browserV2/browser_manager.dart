import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/storage_service/browser/browser_bookmarks_storage_service.dart';
import 'package:app/app/service/storage_service/browser_favicon_url_storage_service.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browserV2/managers/bookmarks_manager.dart';
import 'package:app/feature/browserV2/managers/favicon_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserManager {
  BrowserManager(
    this._bookmarksStorageService,
    this._browserFaviconURLStorageService,
    this._messengerService,
  );

  final BrowserBookmarksStorageService _bookmarksStorageService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  final MessengerService _messengerService;

  late final bookmarks = BookmarksManager(
    _bookmarksStorageService,
    _messengerService,
  );

  late final favicon = FaviconManager(_browserFaviconURLStorageService);

  void init() {
    bookmarks.init();
  }

  Future<void> clear() async {
    await bookmarks.clearBrowserBookmarks();
  }

  void openNewTab() {
    // TODO
  }
}
