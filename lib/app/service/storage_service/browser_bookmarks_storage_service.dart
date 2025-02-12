import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _browserBookmarksDomain = 'browser_bookmarks';
const _browserBookmarksKey = 'browser_bookmarks_key';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser bookmark - related data.
@singleton
class BrowserBookmarksStorageService extends AbstractStorageService {
  BrowserBookmarksStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserBookmarksDomain;

  final GetStorage _storage;

  /// Read list of browser bookmarks items from storage
  List<BrowserBookmarkItem> getBrowserBookmarks() {
    final list = _storage.read<List<dynamic>>(_browserBookmarksKey);
    if (list == null) {
      return [];
    }

    return [
      for (final entry in list)
        BrowserBookmarkItem.fromJson(
          entry as Map<String, dynamic>,
        )
    ];
  }

  /// Save list of browser bookmarks items to storage
  void saveBrowserBookmarks(List<BrowserBookmarkItem> bookmarks) {
    _storage.write(
      _browserBookmarksKey,
      bookmarks.map((e) => e.toJson()).toList(),
    );
  }

  /// Clear browser bookmarks
  Future<void> clearBrowserBookmarks() async {
    await _storage.remove(_browserBookmarksKey);
  }

  @override
  Future<void> init() async {
    await GetStorage.init(container);
  }

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearBrowserBookmarks(),
      ]);
}
