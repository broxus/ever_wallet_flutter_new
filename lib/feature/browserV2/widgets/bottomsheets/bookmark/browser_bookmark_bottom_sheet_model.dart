import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/bookmark/browser_bookmark_bottom_sheet.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BrowserBookmarkBottomSheet]
class BrowserBookmarkBottomSheetModel extends ElementaryModel {
  BrowserBookmarkBottomSheetModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  void removeBookmark(String id) {
    _browserService.bM.removeBrowserBookmarkItem(id);
  }
}
