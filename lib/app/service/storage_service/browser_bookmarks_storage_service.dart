import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _browserBookmarksDomain = 'browser_bookmarks';
const _browserBookmarksKey = 'browser_bookmarks_key';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser bookmark - related data.
@singleton
class BrowserBookmarksStorageService extends AbstractStorageService {
  BrowserBookmarksStorageService(
    @Named(container) this._storage,
  );

  static final _log = Logger('BrowserBookmarksStorageService');

  static const container = _browserBookmarksDomain;

  final GetStorage _storage;

  /// Subject of browser bookmarks items
  final _browserBookmarksSubject = BehaviorSubject<List<BrowserBookmarkItem>>();

  /// Stream of browser bookmarks items
  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserBookmarksSubject;

  /// Get last cached browser bookmarks items
  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserBookmarksSubject.valueOrNull ?? [];

  /// Put browser bookmarks items to stream
  void _streamedBrowserBookmarks() =>
      _browserBookmarksSubject.add(readBrowserBookmarks());

  /// Read list of browser bookmarks items from storage
  List<BrowserBookmarkItem> readBrowserBookmarks() {
    final list = _storage.read<List<dynamic>>(_browserBookmarksKey);
    if (list == null) {
      return [];
    }

    return list
        .map(
          (entry) =>
              BrowserBookmarkItem.fromJson(entry as Map<String, dynamic>),
        )
        .toList();
  }

  /// Save list of browser bookmarks items to storage
  void saveBrowserBookmarks(List<BrowserBookmarkItem> bookmarks) {
    _storage.write(
      _browserBookmarksKey,
      bookmarks.map((e) => e.toJson()).toList(),
    );
    _streamedBrowserBookmarks();
  }

  /// Clear browser bookmarks
  Future<void> clearBrowserBookmarks({
    bool needUndo = true,
  }) async {
    final savedbrowserBookmarks = browserBookmarks;

    await _storage.remove(_browserBookmarksKey);

    if (needUndo) {
      inject<MessengerService>().show(
        Message.info(
          message: LocaleKeys.browserBookmarksDeleted.tr(),
          actionText: LocaleKeys.browserBookmarksDeletedUndo.tr(),
          onAction: () => saveBrowserBookmarks(savedbrowserBookmarks),
          topMargin: DimensSizeV2.d72,
        ),
      );
    }

    _streamedBrowserBookmarks();
  }

  /// Add or replace browser bookmarks item
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
      inject<MessengerService>().show(
        Message.info(
          message: LocaleKeys.browserBookmarkAdded.tr(),
          actionText: LocaleKeys.browserBookmarkAddedUndo.tr(),
          onAction: () => removeBrowserBookmarkItem(item.id, needUndo: false),
          topMargin: DimensSizeV2.d72,
        ),
      );
    }
  }

  /// Remove browser bookmarks item by id
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
      inject<MessengerService>().show(
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

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedBrowserBookmarks();
  }

  @override
  Future<void> clear() async {
    try {
      return await _storage.erase();
    } catch (_) {}
  }
}
