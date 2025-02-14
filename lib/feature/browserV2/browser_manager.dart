import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/storage_service/browser/browser_bookmarks_storage_service.dart';
import 'package:app/app/service/storage_service/browser/browser_favicon_url_storage_service.dart';
import 'package:app/app/service/storage_service/browser/browser_history_storage_service.dart';
import 'package:app/feature/browserV2/managers/bookmarks_manager.dart';
import 'package:app/feature/browserV2/managers/favicon_manager.dart';
import 'package:app/feature/browserV2/managers/history_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserManager {
  BrowserManager(
    this._bookmarksStorageService,
    this._browserFaviconURLStorageService,
    this._browserHistoryStorageService,
    this._messengerService,
  );

  final BrowserBookmarksStorageService _bookmarksStorageService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;
  final BrowserHistoryStorageService _browserHistoryStorageService;

  final MessengerService _messengerService;

  late final bookmarks = BookmarksManager(
    _bookmarksStorageService,
    _messengerService,
  );

  late final favicon = FaviconManager(_browserFaviconURLStorageService);

  late final history = HistoryManager(_browserHistoryStorageService);

  void init() {
    bookmarks.init();
    history.init();
  }

  Future<void> clear() async {
    await bookmarks.clear();
    await history.clear();
  }

  void openNewTab() {
    // TODO
  }
}
