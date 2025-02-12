import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/storage_service/browser_bookmarks_storage_service.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BookmarksManager {
  BookmarksManager(
    this._bookmarksStorageService,
    this._messengerService,
  );

  final BrowserBookmarksStorageService _bookmarksStorageService;
  final MessengerService _messengerService;

  static final _log = Logger('BrowserBookmarksStorageService');

  /// Subject of browser bookmarks items
  final _browserBookmarksSubject = BehaviorSubject<List<BrowserBookmarkItem>>();

  /// Stream of browser bookmarks items
  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserBookmarksSubject;

  /// Get last cached browser bookmarks items
  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserBookmarksSubject.valueOrNull ?? [];

//_streamedBrowserBookmarks

  void init() {
    _fetchBookmarksFromStorage();
  }

  Future<void> clear() async {
    await clearBrowserBookmarks(needUndo: false);
  }

  void saveBrowserBookmarks(List<BrowserBookmarkItem> bookmarks) {
    _bookmarksStorageService.saveBrowserBookmarks(bookmarks);
    _browserBookmarksSubject.add(bookmarks);
  }

  void setBrowserBookmarkItem(
    BrowserBookmarkItem item, {
    bool needUndo = true,
  }) {
    final isAdding =
        browserBookmarks.firstWhereOrNull((i) => i.id == item.id) == null;

    saveBrowserBookmarks([
      ...[...browserBookmarks]..removeWhere((i) => i.id == item.id),
      item,
    ]);

    if (isAdding && needUndo) {
      _messengerService.show(
        Message.info(
          message: LocaleKeys.browserBookmarkAdded.tr(),
          actionText: LocaleKeys.browserBookmarkAddedUndo.tr(),
          onAction: () => removeBrowserBookmarkItem(item.id, needUndo: false),
          topMargin: DimensSizeV2.d72,
        ),
      );
    }
  }

  void removeBrowserBookmarkItem(
    String id, {
    bool needUndo = true,
  }) {
    final item = browserBookmarks.firstWhereOrNull((item) => item.id == id);

    if (item == null) {
      _log.warning('Browser bookmark item with id $id not found');

      return;
    }

    final bookmarks = [...browserBookmarks]..remove(item);

    if (needUndo) {
      _messengerService.show(
        Message.info(
          message: LocaleKeys.browserBookmarkDeleted.tr(),
          actionText: LocaleKeys.browserBookmarkDeletedUndo.tr(),
          onAction: () => setBrowserBookmarkItem(item),
          topMargin: DimensSizeV2.d72,
        ),
      );
    }

    saveBrowserBookmarks(bookmarks);
  }

  /// Clear browser bookmarks
  Future<void> clearBrowserBookmarks({
    bool needUndo = true,
  }) async {
    await _bookmarksStorageService.clearBrowserBookmarks();

    final savedBrowserBookmarks =
        needUndo ? [...browserBookmarks] : <BrowserBookmarkItem>[];

    _browserBookmarksSubject.add([]);

    if (needUndo) {
      _messengerService.show(
        Message.info(
          message: LocaleKeys.browserBookmarksDeleted.tr(),
          actionText: LocaleKeys.browserBookmarksDeletedUndo.tr(),
          onAction: () => saveBrowserBookmarks(savedBrowserBookmarks),
          topMargin: DimensSizeV2.d72,
        ),
      );
    }
  }

  void _fetchBookmarksFromStorage() => _browserBookmarksSubject.add(
        _bookmarksStorageService.getBrowserBookmarks(),
      );
}
