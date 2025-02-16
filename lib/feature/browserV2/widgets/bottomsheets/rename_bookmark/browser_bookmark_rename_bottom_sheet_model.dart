import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BrowserBookmarkRenameBottomSheet]
class BrowserBookmarkRenameBottomSheetModel extends ElementaryModel {
  BrowserBookmarkRenameBottomSheetModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  void renameBookmark(String id, String text) {
    _browserService.bM.renameBookmark(id, text);
  }
}
