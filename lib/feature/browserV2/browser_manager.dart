import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/storage_service/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browserV2/managers/bookmarks_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserManager {
  BrowserManager(
    this._bookmarksStorageService,
    this._messengerService,
  );

  final BrowserBookmarksStorageService _bookmarksStorageService;
  final MessengerService _messengerService;

  late final bookMarksManager = BookmarksManager(
    _bookmarksStorageService,
    _messengerService,
  );

  void init() {
    bookMarksManager.init();
  }

  Future<void> clear() async {
    await bookMarksManager.clearBrowserBookmarks();
  }

  void openNewTab() {
    // TODO
  }
}
