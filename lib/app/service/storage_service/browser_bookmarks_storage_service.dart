import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _browserBookmarksDomain = 'browser_bookmarks';
const _browserBookmarksKey = 'browser_bookmarks_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser bookmark - related data.
@singleton
class BrowserBookmarksStorageService extends AbstractStorageService {
  BrowserBookmarksStorageService(this._storage);

  static final _log = Logger('BrowserBookmarksStorageService');

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  /// Subject of browser bookmarks items
  final _browserBookmarksSubject = BehaviorSubject<List<BrowserBookmarkItem>>();

  /// Stream of browser bookmarks items
  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserBookmarksSubject;

  /// Get last cached browser bookmarks items
  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserBookmarksSubject.valueOrNull ?? [];

  /// Put browser bookmarks items to stream
  Future<void> _streamedBrowserBookmarks() async =>
      _browserBookmarksSubject.add(await readBrowserBookmarks());

  /// Read list of browser bookmarks items from storage
  Future<List<BrowserBookmarkItem>> readBrowserBookmarks() async {
    final encoded = await _storage.get(
      _browserBookmarksKey,
      domain: _browserBookmarksDomain,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;

    return list
        .map(
          (entry) =>
              BrowserBookmarkItem.fromJson(entry as Map<String, dynamic>),
        )
        .toList();
  }

  /// Save list of browser bookmarks items to storage
  Future<void> saveBrowserBookmarks(List<BrowserBookmarkItem> bookmarks) async {
    await _storage.set(
      _browserBookmarksKey,
      jsonEncode(bookmarks),
      domain: _browserBookmarksDomain,
    );

    await _streamedBrowserBookmarks();
  }

  /// Clear browser bookmarks
  Future<void> clearBrowserBookmarks() async {
    await _storage.delete(
      _browserBookmarksKey,
      domain: _browserBookmarksDomain,
    );

    await _streamedBrowserBookmarks();
  }

  /// Add browser bookmarks item
  Future<void> addBrowserBookmarkItem(BrowserBookmarkItem item) async {
    await saveBrowserBookmarks([...browserBookmarks, item]);
  }

  /// Remove browser bookmarks item by id
  Future<void> removeBrowserBookmarkItem(String id) async {
    final item = browserBookmarks.firstWhereOrNull((item) => item.id == id);

    if (item == null) {
      _log.warning('Browser bookmark item with id $id not found');
      return;
    }

    final bookmarks = [...browserBookmarks]..remove(item);

    inject<MessengerService>().show(
      Message.info(
        message: LocaleKeys.browserBookmarkDeleted.tr(),
        actionText: LocaleKeys.browserBookmarkDeletedUndo.tr(),
        onAction: () => addBrowserBookmarkItem(item),
      ),
    );

    await saveBrowserBookmarks(bookmarks);
  }

  @override
  Future<void> init() => Future.wait([
        _streamedBrowserBookmarks(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearBrowserBookmarks(),
      ]);
}
