import 'package:app/feature/browserV2/managers/favicon_manager.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/feature/browserV2/widgets/browser_resource_item/browser_resource_item.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserResourceItem]
class BrowserResourceItemModel extends ElementaryModel {
  BrowserResourceItemModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<FaviconData> get allFaviconsState =>
      _browserService.fM.faviconsState;

  void fetchFavicons(Uri? uri) {
    if (uri == null) {
      return;
    }
    _browserService.fM.fetchFavicon(uri);
  }
}
