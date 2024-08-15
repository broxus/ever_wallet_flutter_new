import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';

class WebsiteInfoModel extends ElementaryModel {
  WebsiteInfoModel(
    ErrorHandler errorHandler,
    this._browserFaviconURLStorageService,
  ) : super(errorHandler: errorHandler);

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  Future<String?> getFaviconUrl(Uri uri) =>
      _browserFaviconURLStorageService.getFaviconURL(uri);
}
