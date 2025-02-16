import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browserV2/screens/bookmarks/bookmarks_screen.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BookmarksScreen]
class BookmarksScreenModel extends ElementaryModel {
  BookmarksScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  List<BrowserBookmarkItem> get sortedBookmarks =>
      _browserService.bM.sortedBookmarks;

  void setBookmark(BrowserBookmarkItem item) {
    _browserService.bM.setBrowserBookmarkItem(item, needUndo: false);
  }

  void removeBookmark(String id) {
    _browserService.bM.removeBrowserBookmarkItem(id);
  }

  void clearBookmarks() => _browserService.bM.clearBookmarks();
}
